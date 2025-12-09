import '../models/assessment_model.dart';

class ScoringService {
  /// Calculates the AIP scores based on the input assessment data.
  /// Returns a new AssessmentModel with the calculated_results populated.
  static AssessmentModel calculate(AssessmentModel input) {
    // 1. FWB (Functional Well Being) Calculation
    final fwb = _calculateFWB(input.inputsFwb);

    // 2. CT (Care Team) Calculation
    final ct = _calculateCT(input.inputsCt);

    // 3. ES (Environmental Safety) Calculation
    final esResults = _calculateES(input.inputsEs);
    final es = esResults['score']!;
    
    // 4. Interaction Model (ICS)
    final ics = _calculateICS(fwb, ct);

    // 5. Blended Score (BLS)
    final bls = _calculateBLS(ics, ct);

    // 6. Final AIP Score
    // Logic: The environment acts as a "container". If the container is unsafe,
    // it reduces the capacity of the entire system by a percentage.
    const k = 0.5; // Strength of environmental influence
    final envDeficit = 100 - es; // e.g., 100 - 65 = 35
    final penaltyPercentage = envDeficit * k; // e.g., 35 * 0.5 = 17.5%

    // Apply the penalty factor (e.g., 1 - 0.175 = 0.825)
    final finalScore = bls * (1 - (penaltyPercentage / 100));

    return input.copyWith(
      calculatedResults: CalculatedResults(
        scoreFwb: fwb,
        scoreCt: ct,
        scoreEs: es,
        scoreIcs: ics,
        scoreBls: bls,
        scoreFinalAip: finalScore,
      ),
    );
  }

  static double _calculateFWB(InputsFWB inputs) {
    // ADL %
    final adlSum = inputs.adls.bathing +
        inputs.adls.dressing +
        inputs.adls.toileting +
        inputs.adls.transferring +
        inputs.adls.continence +
        inputs.adls.feeding;
    final adlPercent = (adlSum / 12.0) * 100;

    // IADL %
    final iadlSum = inputs.iadls.managingFinances +
        inputs.iadls.handlingTransportation +
        inputs.iadls.shopping +
        inputs.iadls.preparingMeals +
        inputs.iadls.usingTelephone +
        inputs.iadls.managingMedication +
        inputs.iadls.housekeeping;
    final iadlPercent = (iadlSum / 14.0) * 100;

    // Other components
    final gaitPercent = (inputs.gaitSpeedScore / 5.0) * 100;
    final mobilityPercent = (inputs.mobilityDeviceScore / 4.0) * 100;
    final gripPercent = (inputs.gripStrengthScore / 4.0) * 100;
    final fallsPercent = (inputs.fallsHistoryScore / 3.0) * 100;

    // Final FWB Score
    return (adlPercent * 0.35) +
        (iadlPercent * 0.25) +
        (gaitPercent * 0.10) +
        (mobilityPercent * 0.15) +
        (gripPercent * 0.10) +
        (fallsPercent * 0.05);
  }

  static double _calculateCT(InputsCT inputs) {
    // Coverage Score
    double coverageScore;
    switch (inputs.coverageDaysPerWeek) {
      case 0:
        coverageScore = 10.0;
        break;
      case 1:
        coverageScore = 40.0;
        break;
      case 2:
      case 3:
        coverageScore = 65.0;
        break;
      case 4:
      case 5:
        coverageScore = 85.0;
        break;
      case 6:
      case 7:
        coverageScore = 100.0;
        break;
      default:
        coverageScore = 10.0; // Fallback for invalid input
    }

    // Coordination Score
    final cpScore = inputs.coordination.careplanUpToDate ? 100.0 : 50.0;
    final commScore = (inputs.coordination.communicationRating / 5.0) * 100;
    final coordinationScore = (cpScore + commScore) / 2.0;

    // Final CT Score
    // Assuming reliability_percent and continuity_percent are 0-100 based on schema context
    return (coverageScore * 0.35) +
        (inputs.reliabilityPercent * 0.25) +
        (inputs.continuityPercent * 0.20) +
        (coordinationScore * 0.20);
  }

  static Map<String, double> _calculateES(InputsES inputs) {
    final fallHazards = (inputs.fallHazardsLevel / 4.0) * 100;
    final bathroom = (inputs.bathroomSafetyLevel / 4.0) * 100;
    final kitchen = (inputs.kitchenSafetyLevel / 4.0) * 100;
    final layout = (inputs.homeLayoutLevel / 4.0) * 100;

    final finalEsScore = (fallHazards * 0.3) +
        (bathroom * 0.3) +
        (kitchen * 0.2) +
        (layout * 0.2);

    final envAdjustment = (finalEsScore - 100) * 0.175;

    return {'score': finalEsScore, 'adjustment': envAdjustment};
  }

  static double _calculateICS(double fwb, double ct) {
    final fwbNorm = fwb / 100.0;
    final ctNorm = ct / 100.0;
    return 100 *
        ((0.2 * fwbNorm) + (0.2 * ctNorm) + (0.6 * fwbNorm * ctNorm));
  }

  static double _calculateBLS(double ics, double ct) {
    const lambda = 0.3;
    return (lambda * ics) + ((1 - lambda) * ct);
  }

  // Helper method no longer needed in new logic but kept if we need to revert
  static double _calculateFinalScore(double bls, double envAdjustment) {
    const k = 0.5;
    return bls + (envAdjustment * k);
  }
}
