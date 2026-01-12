import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aging_in_place/models/assessment_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_service.g.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  /// Saves or updates an assessment in the senior's sub-collection.
  Future<void> saveAssessment(String seniorId, AssessmentModel assessment) async {
    try {
      await _firestore
          .collection('seniors')
          .doc(seniorId)
          .collection('assessments')
          .doc(assessment.metadata.assessmentId)
          .set(assessment.toJson());
          
      // Ensure the senior document exists and the user is in the care team
      // (This is a safety check for new profiles)
      await _firestore.collection('seniors').doc(seniorId).set({
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
    } catch (e) {
      print('Error saving assessment: $e');
      throw Exception('Failed to save assessment');
    }
  }

  /// Retrieves a stream of assessments for a specific senior, ordered by date.
  Stream<List<AssessmentModel>> getAssessmentsForSenior(String seniorId) {
    return _firestore
        .collection('seniors')
        .doc(seniorId)
        .collection('assessments')
        .orderBy('metadata.created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AssessmentModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Creates a new senior profile and adds the creator to the care team.
  Future<String> createSeniorProfile(String creatorUserId, String seniorName) async {
    final docRef = _firestore.collection('seniors').doc();
    await docRef.set({
      'name': seniorName,
      'care_team': [creatorUserId],
      'created_at': FieldValue.serverTimestamp(),
      'created_by': creatorUserId,
    });
    return docRef.id;
  }

  /// Gets all seniors that a user is a member of.
  Stream<List<Map<String, dynamic>>> getSeniorsForUser(String userId) {
    return _firestore
        .collection('seniors')
        .where('care_team', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    });
  }

  /// Creates a public invitation link (no email pre-defined).
  Future<String> createPublicInvite({
    required String seniorId,
    required String seniorName,
    required String fromUserId,
    required String fromUserName,
  }) async {
    final docRef = _firestore.collection('invites').doc();
    await docRef.set({
      'senior_id': seniorId,
      'senior_name': seniorName,
      'from_id': fromUserId,
      'from_name': fromUserName,
      'status': 'pending',
      'is_public': true,
      'created_at': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Gets invite details by ID.
  Future<Map<String, dynamic>?> getInviteById(String inviteId) async {
    final doc = await _firestore.collection('invites').doc(inviteId).get();
    if (!doc.exists) return null;
    return {'id': doc.id, ...doc.data()!};
  }

  /// Gets a single user's profile info.
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.exists ? {'id': doc.id, ...doc.data()!} : null;
  }

  /// Gets the last assessment entry for a specific user and senior.
  Future<DateTime?> getLastEntryForMember(String seniorId, String userId) async {
    try {
      final lastAssessment = await _firestore
          .collection('seniors')
          .doc(seniorId)
          .collection('assessments')
          .where('metadata.created_by', isEqualTo: userId)
          .orderBy('metadata.created_at', descending: true)
          .limit(1)
          .get();
      
      if (lastAssessment.docs.isNotEmpty) {
        return (lastAssessment.docs.first.data()['metadata']['created_at'] as Timestamp).toDate();
      }
    } catch (e) {
      print('Error fetching last entry: $e');
    }
    return null;
  }

  /// Removes a user from a care team.
  Future<void> removeFromCareTeam(String seniorId, String userId) async {
    await _firestore.collection('seniors').doc(seniorId).update({
      'care_team': FieldValue.arrayRemove([userId]),
    });
  }

  /// Ensures a user has a profile document.
  Future<void> ensureUserProfile(String userId, String email) async {
    await _firestore.collection('users').doc(userId).set({
      'email': email,
      'last_seen': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Creates a pending invitation.
  Future<void> createInvite({
    required String seniorId,
    required String seniorName,
    required String fromUserId,
    required String fromUserName,
    required String toEmail,
  }) async {
    await _firestore.collection('invites').add({
      'senior_id': seniorId,
      'senior_name': seniorName,
      'from_id': fromUserId,
      'from_name': fromUserName,
      'to_email': toEmail.toLowerCase().trim(),
      'status': 'pending',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  /// Gets pending invites for a specific email.
  Stream<List<Map<String, dynamic>>> getInvitesForEmail(String email) {
    return _firestore
        .collection('invites')
        .where('to_email', isEqualTo: email.toLowerCase().trim())
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    });
  }

  /// Accepts an invitation.
  Future<void> acceptInvite(String inviteId, String seniorId, String userId) async {
    final batch = _firestore.batch();
    
    // 1. Add user to care team
    batch.update(_firestore.collection('seniors').doc(seniorId), {
      'care_team': FieldValue.arrayUnion([userId]),
    });
    
    // 2. Mark invite as accepted
    batch.update(_firestore.collection('invites').doc(inviteId), {
      'status': 'accepted',
      'accepted_at': FieldValue.serverTimestamp(),
    });
    
    await batch.commit();
  }
}

// Riverpod Provider
@riverpod
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(FirebaseFirestore.instance);
}
