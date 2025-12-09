import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aging_in_place/models/assessment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_service.g.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  /// Saves or updates an assessment in the 'assessments' collection.
  Future<void> saveAssessment(AssessmentModel assessment) async {
    try {
      await _firestore
          .collection('assessments')
          .doc(assessment.metadata.assessmentId)
          .set(assessment.toJson());
    } catch (e) {
      print('Error saving assessment: $e');
      throw Exception('Failed to save assessment');
    }
  }

  /// Retrieves a stream of assessments for a specific senior, ordered by date.
  Stream<List<AssessmentModel>> getAssessmentsForSenior(String seniorId) {
    return _firestore
        .collection('assessments')
        .where('metadata.senior_id', isEqualTo: seniorId)
        .orderBy('metadata.created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AssessmentModel.fromJson(doc.data()))
          .toList();
    });
  }
}

// Riverpod Provider
@riverpod
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(FirebaseFirestore.instance);
}
