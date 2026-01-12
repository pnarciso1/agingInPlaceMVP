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
  Future<AssessmentModel> build(String seniorId) async {
    final user = ref.watch(authServiceProvider).currentUser;
    final userId = user?.uid ?? '';
    final firestoreService = ref.read(firestoreServiceProvider);

    // Generate a NEW ID for this specific session
    final newSessionId = DateTime.now().millisecondsSinceEpoch.toString();
    print('DEBUG: Initializing Controller for Senior: $seniorId, Session ID: $newSessionId');

    try {
      final assessmentsStream = firestoreService.getAssessmentsForSenior(seniorId);
      // Wait for the first value
      final assessments = await assessmentsStream.first;
      
      if (assessments.isNotEmpty) {
        // Found previous state! Use it as baseline.
        print('DEBUG: Found ${assessments.length} previous assessments for $seniorId. Using latest as baseline.');
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
             seniorId: seniorId,
             createdAt: DateTime.now(),
             createdBy: userId,
          ),
        );
      }
    } catch (e) {
      print('Error fetching previous assessment for $seniorId: $e');
    }

    // No previous state -> Start fresh
    print('DEBUG: No history found for $seniorId. Starting fresh.');
    _currentStep = AssessmentStep.askingName; // Explicitly start at name
    
    final initial = AssessmentModel(
      metadata: AssessmentMetadata(
        assessmentId: newSessionId,
        seniorId: seniorId,
        createdAt: DateTime.now(),
        createdBy: userId,
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
    final seniorId = current.metadata.seniorId;
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
           return aiResponse;
         }

         // 2. CALL REAL AI
        final result = await _aiService.processObservation(
          currentAssessment: current, 
          userObservation: userMessage,
        );

        if (result != null) {
          current = ScoringService.calculate(result.assessment);
          print('DEBUG: AI Updated Fields. New AIP Score: ${current.calculatedResults.scoreFinalAip}');
          
          aiResponse = result.message;
          
          // 3. AUTO SAVE ON SUCCESS
          state = AsyncValue.data(current);
          await saveCurrentAssessment(quiet: true); // Auto-save!
        } else {
          aiResponse = "I'm having trouble processing that right now. Please try again.";
          state = AsyncValue.data(current); // Keep state consistent
        }
        break;
    }

    if (state.value != current) {
       state = AsyncValue.data(current);
    }
    
    return aiResponse;
  }

  Future<void> saveCurrentAssessment({bool quiet = false}) async {
    if (!state.hasValue) return;
    
    final firestoreService = ref.read(firestoreServiceProvider);
    final assessment = state.value!;
    try {
      await firestoreService.saveAssessment(assessment.metadata.seniorId, assessment);
      print('SUCCESS: Assessment saved to Firestore for Senior: ${assessment.metadata.seniorId}!');
    } catch (e) {
      print('ERROR: Failed to save assessment: $e');
      if (!quiet) throw e; 
    }
  }
}
