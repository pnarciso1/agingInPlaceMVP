import 'dart:convert';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:aging_in_place/models/assessment_model.dart';

class AIService {
  // Trying gemini-2.0-flash-exp as 1.5 is retired.
  static const String _modelId = 'gemini-2.0-flash-exp';

  Future<AssessmentModel?> processObservation({
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
      1. Update the Assessment JSON based *only* on the new observation for $subjectName. 
      2. Keep existing values if the observation doesn't change them.
      3. Return ONLY the valid JSON object. Do not include markdown code blocks (```json).
      
      SCORING RULES (Be realistic, not optimistic):
      - If the user mentions "slowing down" or "unsteady", Gait Speed should drop (e.g. to 3 or 4), not stay at 5.
      - If they need "some help" with ADLs, score as 1 (Needs Assistance), not 2 (Independent).
      - If they live alone and family visits are rare/inconsistent, Coverage Days/Reliability should decrease.
      - Fall Hazards: 0=Many Hazards (Bad) to 4=No Hazards (Safe).
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text == null) return null;

      // Clean the output: sometimes AI adds ```json ... ``` wrappers
      String cleanedJson = response.text!.replaceAll('```json', '').replaceAll('```', '').trim();

      final Map<String, dynamic> jsonMap = jsonDecode(cleanedJson);

      return AssessmentModel.fromJson(jsonMap);
    } catch (e) {
      print('CRITICAL AI ERROR: $e');
      return null; // Return null so we don't crash the score to 0
    }
  }
}
