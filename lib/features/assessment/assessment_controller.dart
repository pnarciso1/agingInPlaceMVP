import 'package:aging_in_place/models/assessment_model.dart';
import 'package:aging_in_place/services/scoring_service.dart';
import 'package:aging_in_place/services/ai_service.dart';
import 'package:aging_in_place/services/firestore_service.dart';
import 'package:aging_in_place/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assessment_controller.g.dart';

enum AssessmentStep { askingName, askingAge, askingGender, askingLiving, activeAssessment }

@riverpod
class AssessmentController extends _$AssessmentController {
  final _aiService = AIService();
  AssessmentStep _currentStep = AssessmentStep.askingName;

  @override
  Future<AssessmentModel> build() async {
    final user = ref.watch(authServiceProvider).currentUser;
    final userId = user?.uid ?? '';
    final firestoreService = ref.read(firestoreServiceProvider);

    // Generate a NEW ID for this specific session
    final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    print('DEBUG: Initializing Controller for Session ID: $newSessionId');

    try {
      final assessmentsStream = firestoreService.getAssessmentsForSenior(userId);
      // Wait for the first value
      final assessments = await assessmentsStream.first;
      
      if (assessments.isNotEmpty) {
        // Found previous state! Use it as baseline.
        print('DEBUG: Found ${assessments.length} previous assessments. Using latest as baseline.');
        final latest = assessments.first;
        
        // Check if we already have demographic info
        if (latest.metadata.subjectName != null && latest.metadata.subjectName!.isNotEmpty) {
            _currentStep = AssessmentStep.activeAssessment;
        } else {
            _currentStep = AssessmentStep.askingName;
        }

        return latest.copyWith(
          metadata: latest.metadata.copyWith(
             assessmentId: newSessionId, // New Session ID
             createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      print('Error fetching previous assessment: $e');
    }

    // No previous state -> Start fresh
    print('DEBUG: No history found. Starting fresh (100).');
    _currentStep = AssessmentStep.askingName; // Explicitly start at name
    
    final initial = AssessmentModel(
      metadata: AssessmentMetadata(
        assessmentId: newSessionId,
        seniorId: userId,
        createdAt: DateTime.now(),
      ),
      inputsFwb: const InputsFWB(),
      inputsCt: const InputsCT(),
      inputsEs: const InputsES(),
      calculatedResults: const CalculatedResults(),
    );
    
    return ScoringService.calculate(initial);
  }
  
  // Public getter to let UI check if it should show initial prompt
  AssessmentStep get currentStep => _currentStep;

  Future<String> parseMessage(String userMessage) async {
    if (!state.hasValue) return "Error: No active assessment state.";
    
    var current = state.value!;
    String aiResponse = "";
    final name = current.metadata.subjectName ?? "the senior";

    switch (_currentStep) {
      case AssessmentStep.askingName:
        current = current.copyWith(
          metadata: current.metadata.copyWith(subjectName: userMessage),
        );
        _currentStep = AssessmentStep.askingAge;
        aiResponse = "Thanks. How old is $userMessage?";
        // Auto-save basic info
        state = AsyncValue.data(current); 
        await saveCurrentAssessment(quiet: true);
        break;

      case AssessmentStep.askingAge:
        final age = int.tryParse(userMessage.replaceAll(RegExp(r'[^0-9]'), '')) ?? 75; // Default if parse fails
        current = current.copyWith(
           metadata: current.metadata.copyWith(subjectAge: age),
        );
        _currentStep = AssessmentStep.askingGender;
        // Check gender for future pronouns if we wanted to (omitted for brevity, defaulting to name)
        aiResponse = "Got it. What is $userMessage's gender?"; 
        // Using "their" here as we don't know the name's possession yet, actually name is better: "What is [Name]'s gender?"
        // But userMessage here is the AGE. So:
        final tempName = current.metadata.subjectName ?? "their";
        aiResponse = "Got it. What is $tempName's gender?";
        state = AsyncValue.data(current);
        await saveCurrentAssessment(quiet: true);
        break;

      case AssessmentStep.askingGender:
         current = current.copyWith(
           metadata: current.metadata.copyWith(subjectGender: userMessage),
        );
        _currentStep = AssessmentStep.askingLiving;
        final tempName = current.metadata.subjectName ?? "they";
        aiResponse = "And does $tempName live alone, with a spouse, or with family?";
        state = AsyncValue.data(current);
        await saveCurrentAssessment(quiet: true);
        break;

      case AssessmentStep.askingLiving:
         current = current.copyWith(
           metadata: current.metadata.copyWith(livingSituation: userMessage),
        );
        _currentStep = AssessmentStep.activeAssessment;
        final updatedName = current.metadata.subjectName ?? "the senior";
        
        // --- NEW DETAILED PROMPT ---
        aiResponse = """
Thank you. Now, let's establish a baseline for $updatedName.
To give you an accurate score, please describe $updatedName's ability to:
1. Walk and move around the house.
2. Handle daily tasks like bathing, dressing, and cooking.
3. Stay safe from falls (any recent stumbles?).
4. Socialize and manage medications.
""";
        state = AsyncValue.data(current);
        await saveCurrentAssessment(quiet: true);
        break;

      case AssessmentStep.activeAssessment:
         // 1. EXIT INTENT DETECTION
         final lowerMsg = userMessage.toLowerCase();
         if (lowerMsg == 'no' || lowerMsg == 'nope' || lowerMsg.contains('nothing else') || lowerMsg == 'that is all') {
           aiResponse = "Thank you. Remember, whenever you observe any changes in $name, feel free to tell me about it so I can update $name's score and provide suggestions to help $name age in place.";
           // Do not call AI service. Just return close message.
           return aiResponse;
         }

         // 2. CALL REAL AI
        final updatedAssessment = await _aiService.processObservation(
          currentAssessment: current, 
          userObservation: userMessage,
        );

        if (updatedAssessment != null) {
          current = ScoringService.calculate(updatedAssessment);
          print('DEBUG: AI Updated Fields. New AIP Score: ${current.calculatedResults.scoreFinalAip}');
          aiResponse = "Thank you. I've logged the information and updated $name's aging in place score. Is there anything more you want to record regarding your observations of $name?";
          
          // 3. AUTO SAVE ON SUCCESS
          state = AsyncValue.data(current);
          await saveCurrentAssessment(quiet: true); // Auto-save!
        } else {
          aiResponse = "I'm having trouble processing that right now. Please try again.";
          state = AsyncValue.data(current); // Keep state consistent
        }
        break;
    }

    // Update State (Redundant if set above, but safe)
    if (state.value != current) {
       state = AsyncValue.data(current);
    }
    
    return aiResponse;
  }

  Future<void> saveCurrentAssessment({bool quiet = false}) async {
    if (!state.hasValue) return;
    
    final firestoreService = ref.read(firestoreServiceProvider);
    try {
      await firestoreService.saveAssessment(state.value!);
      print('SUCCESS: Assessment saved to Firestore! ID: ${state.value!.metadata.assessmentId}');
    } catch (e) {
      print('ERROR: Failed to save assessment: $e');
      if (!quiet) throw e; // Only throw if explicitly requested (manual save)
    }
  }
}
