import 'dart:convert';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:aging_in_place/models/assessment_model.dart';

class AIProcessingResult {
  final AssessmentModel assessment;
  final String message;

  AIProcessingResult({required this.assessment, required this.message});
}

class AIService {
  // Trying gemini-2.0-flash-exp as 1.5 is retired.
  static const String _modelId = 'gemini-2.0-flash-exp';

  Future<AIProcessingResult?> processObservation({
    required AssessmentModel currentAssessment,
    required String userObservation,
    // Note: apiKey is no longer needed as Firebase handles auth internally
  }) async {
    try {
      final model = FirebaseVertexAI.instance.generativeModel(
        model: _modelId,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json', // Forces JSON output
          temperature: 0.2, // Low temperature for consistent math/scoring
        ),
      );

      final subjectName = currentAssessment.metadata.subjectName ?? 'the senior';

      // We send the current state + the new observation
      final prompt = '''
      You are an expert Geriatric Care Manager assessing "$subjectName".
      
      Current Assessment JSON:
      ${jsonEncode(currentAssessment.toJson())}

      New Observation:
      "$userObservation"

      INSTRUCTIONS:
      1. Analyze the observation for both specific incidents AND broader "ripple effects".
      2. Update the Assessment JSON based on the new observation.
      3. Generate a conversational `response_message` to the user.
      
      CONVERSATIONAL LOGIC (The "Holistic Check"):
      - **Incident Reported:** If the user reports a negative event (e.g., incontinence, fall, confusion), do NOT just ask about that event. Proactively ask about *related* daily functions to build a holistic picture.
          - Example: "Dad had an accident" -> Ask: "How is he managing bathing? Is he eating well? Does he seem confused?"
          - Example: "Mom is forgetting things" -> Ask: "Is she taking her meds? How is her sleep?"
      - **Improvement Reported:** If the user reports a positive change (e.g., "Walking better", "Hired a caregiver"), validate it and ask how it's impacting other areas.
          - Example: "We hired help" -> "That's great! Has that helped with her meals or housekeeping too?"

      SCORING RULES:
      - **Decline:** 
          - If "slowing down" or "unsteady", drop Gait Speed (3-4).
          - If needing "some help", drop ADLs to 1.
          - If living alone/isolated, drop Coverage Reliability.
          - Fall Hazards: 0=Many Hazards -> 4=No Hazards.
      
      - **RECOVERY (CRITICAL):** 
          - If user reports NEW support (e.g., "caregiver comes 3 days/week"), INCREASE Coverage Frequency/Reliability.
          - If functional improvement (e.g., "walking better", "therapy working"), INCREASE Gait/ADL scores.
          - Do not keep scores artificially low if the situation is remediated.

      OUTPUT FORMAT:
      {
        "assessment": { ... full assessment model structure ... },
        "response_message": "Your conversational response here..."
      }
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text == null) return null;

      // Clean the output: sometimes AI adds ```json ... ``` wrappers
      String cleanedJson = response.text!.replaceAll('```json', '').replaceAll('```', '').trim();

      final Map<String, dynamic> jsonMap = jsonDecode(cleanedJson);

      if (jsonMap.containsKey('assessment') && jsonMap.containsKey('response_message')) {
         return AIProcessingResult(
           assessment: AssessmentModel.fromJson(jsonMap['assessment']),
           message: jsonMap['response_message'],
         );
      } else {
        // Fallback for older format if AI hallucinates
        return AIProcessingResult(
          assessment: AssessmentModel.fromJson(jsonMap),
          message: "Thank you. I've updated the assessment based on your notes.",
        );
      }
      
    } catch (e) {
      print('CRITICAL AI ERROR: $e');
      return null; // Return null so we don't crash the score to 0
    }
  }
}
