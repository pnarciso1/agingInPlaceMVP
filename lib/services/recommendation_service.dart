import '../models/assessment_model.dart';
import '../models/recommendation_model.dart';

class RecommendationService {
  static List<Recommendation> generate(AssessmentModel current, {AssessmentModel? previous}) {
    final List<Recommendation> recommendations = [];
    final inputsFwb = current.inputsFwb;
    final inputsEs = current.inputsEs;
    final inputsCt = current.inputsCt;
    final score = current.calculatedResults.scoreFinalAip;
    
    // Get the name, capitalizing the first letter if it exists
    String name = current.metadata.subjectName ?? "your loved one";
    if (name.isNotEmpty) {
      name = name[0].toUpperCase() + name.substring(1);
    }

    // --- COMPARISON LOGIC (Dynamic Changes) ---
    if (previous != null) {
      final prevScore = previous.calculatedResults.scoreFinalAip;
      
      // 1. Significant Improvement (> 2 points)
      if (score > prevScore + 2) {
        recommendations.add(const Recommendation(
          title: "Improvements Detected!",
          description: "Great job! The AIP score has improved. This shows that your interventions are working. Keep up the proactive care.",
          type: "General",
          actionLabel: "View Progress",
        ));
      }

      // 2. Significant Decline (> 5 points)
      if (score < prevScore - 5) {
        recommendations.add(const Recommendation(
          title: "Attention Needed",
          description: "We've noticed a drop in the score. Review recent changes in health or environment. Early intervention prevents further decline.",
          type: "Health",
          actionLabel: "Review Changes",
        ));
      }
    }

    // --- STANDARD LOGIC (Current State) ---

    // 3. Fall Risk Logic
    if (inputsFwb.fallsHistoryScore < 3 || inputsFwb.gaitSpeedScore < 3) {
      recommendations.add(Recommendation(
        title: "Fall Risk Assessment",
        description: "Mobility issues detected for $name. Consider a professional safety check (often free from Fire Dept) or a PT evaluation.",
        type: "Health",
        actionLabel: "View Resources",
      ));
    }

    // 4. Bathroom Safety Logic
    if (inputsEs.bathroomSafetyLevel < 4) {
      recommendations.add(const Recommendation(
        title: "Bathroom Safety",
        description: "Bathroom hazards detected. Installing grab bars or a transfer bench can significantly reduce fall risk.",
        type: "Home",
        actionLabel: "View Options",
      ));
    }

    // 5. Care Gap Logic
    if (inputsCt.coverageDaysPerWeek < 4 && score < 95) {
      recommendations.add(Recommendation(
        title: "Support Gap",
        description: "$name might need coverage on more days. Can family rotate shifts, or is external help an option?",
        type: "Care",
        actionLabel: "Plan Schedule",
      ));
    }

    // 6. ADL Support Logic
    if (inputsFwb.adls.bathing < 2 || inputsFwb.adls.dressing < 2) {
      recommendations.add(Recommendation(
        title: "Daily Activity Help",
        description: "Routine tasks like bathing are becoming difficult for $name. Consistent help here is crucial.",
        type: "Health",
        actionLabel: "View Tips",
      ));
    }

    // --- PROACTIVE / MAINTENANCE LOGIC ---

    // 7. High Score Maintenance (Encouragement)
    if (score >= 95) {
      recommendations.add(Recommendation(
        title: "Proactive Wellness",
        description: "Excellent score! Help $name focus on preventative care: regular hydration, social activities, and gentle exercise.",
        type: "General",
        actionLabel: "Wellness Tips",
      ));
    }

    // 8. Fallback (Ensure list is never empty if there's any data)
    if (recommendations.isEmpty) {
      recommendations.add(const Recommendation(
        title: "Stay Vigilant",
        description: "Things look stable for now. Continue to monitor daily activities and log any small changes.",
        type: "General",
        actionLabel: "Log Note",
      ));
    }

    return recommendations;
  }
}
