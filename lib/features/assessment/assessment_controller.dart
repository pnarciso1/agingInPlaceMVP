import 'package:aging_in_place/models/assessment_model.dart';
import 'package:aging_in_place/services/scoring_service.dart';
import 'package:aging_in_place/services/ai_service.dart';
import 'package:aging_in_place/services/firestore_service.dart';
import 'package:aging_in_place/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assessment_controller.g.dart';

@riverpod
class AssessmentController extends _$AssessmentController {
  final _aiService = AIService();

  @override
  AssessmentModel build() {
    // Get the current user ID from the AuthService provider
    // NOTE: We use read() here because build() is synchronous and we assume user is logged in 
    // when this screen is accessed. If not, it defaults to empty string which is safe but won't save correctly.
    final user = ref.watch(authServiceProvider).currentUser;
    final userId = user?.uid ?? '';

    // Initial State: High/Perfect score (100)
    final initial = AssessmentModel(
      metadata: AssessmentMetadata(
        assessmentId: DateTime.now().millisecondsSinceEpoch.toString(),
        seniorId: userId, // Use actual User ID
        createdAt: DateTime.now(),
      ),
      inputsFwb: const InputsFWB(
        adls: ADLs(),
        iadls: IADLs(),
      ),
      inputsCt: const InputsCT(
        coordination: Coordination(),
      ),
      inputsEs: const InputsES(),
      calculatedResults: const CalculatedResults(),
    );
    
    return ScoringService.calculate(initial);
  }

  Future<void> parseMessage(String userMessage) async {
    final current = state;

    final updatedAssessment = await _aiService.processObservation(
      currentAssessment: current, 
      userObservation: userMessage,
    );

    if (updatedAssessment != null) {
      final calculated = ScoringService.calculate(updatedAssessment);
      print('DEBUG: AI Updated Fields. New AIP Score: ${calculated.calculatedResults.scoreFinalAip}');
      state = calculated;
    } else {
      print("AI Failed to parse. Keeping old state.");
      state = current;
    }
  }

  Future<void> saveCurrentAssessment() async {
    final firestoreService = ref.read(firestoreServiceProvider);
    try {
      await firestoreService.saveAssessment(state);
      print('SUCCESS: Assessment saved to Firestore!');
    } catch (e) {
      print('ERROR: Failed to save assessment: $e');
    }
  }
}
