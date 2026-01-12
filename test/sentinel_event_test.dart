import 'package:flutter_test/flutter_test.dart';
import 'package:aging_in_place/models/assessment_model.dart';
import 'package:aging_in_place/services/scoring_service.dart';

void main() {
  group('Sentinel Event Scoring Tests', () {
    test('Incontinence should lower the score significantly', () {
      final base = AssessmentModel(
        metadata: AssessmentMetadata(
          assessmentId: 'test',
          seniorId: 'test',
          createdAt: DateTime.now(),
        ),
        inputsFwb: const InputsFWB(
          adls: ADLs(continence: 2), // Continent
        ),
        inputsCt: const InputsCT(),
        inputsEs: const InputsES(),
        calculatedResults: const CalculatedResults(),
      );

      final withIncontinence = base.copyWith(
        inputsFwb: base.inputsFwb.copyWith(
          adls: const ADLs(continence: 1), // Incontinent
        ),
      );

      final resultBase = ScoringService.calculate(base);
      final resultIncontinence = ScoringService.calculate(withIncontinence);

      print('Base Score: ${resultBase.calculatedResults.scoreFinalAip}');
      print('Incontinence Score: ${resultIncontinence.calculatedResults.scoreFinalAip}');

      // The incontinence score should be lower than the base score by more than just the FWB drop
      // Base score is ~100. Incontinence penalty is -10. FWB drop is also there.
      expect(resultIncontinence.calculatedResults.scoreFinalAip, lessThan(resultBase.calculatedResults.scoreFinalAip - 10));
    });

    test('Recent fall should lower the score significantly', () {
      final base = AssessmentModel(
        metadata: AssessmentMetadata(
          assessmentId: 'test',
          seniorId: 'test',
          createdAt: DateTime.now(),
        ),
        inputsFwb: const InputsFWB(
          fallsHistoryScore: 3, // No falls
        ),
        inputsCt: const InputsCT(),
        inputsEs: const InputsES(),
        calculatedResults: const CalculatedResults(),
      );

      final withFall = base.copyWith(
        inputsFwb: base.inputsFwb.copyWith(
          fallsHistoryScore: 2, // Recent fall
        ),
      );

      final resultBase = ScoringService.calculate(base);
      final resultFall = ScoringService.calculate(withFall);

      print('Base Score: ${resultBase.calculatedResults.scoreFinalAip}');
      print('Fall Score: ${resultFall.calculatedResults.scoreFinalAip}');

      // Fall penalty is -5 for score < 3, -15 for score < 2.
      expect(resultFall.calculatedResults.scoreFinalAip, lessThan(resultBase.calculatedResults.scoreFinalAip - 5));
    });
  });
}
