import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_checkup_app/data/models/complaint_response_model.dart';

class ComplaintService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> submitComplaint(String userId, String complaint) async {
    try {
      await _firestore.collection('complaints').add({
        'userId': userId,
        'complaint': complaint,
        'response': '',
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<List<ComplaintResponseModel>> getComplaints() {
    return _firestore.collection('complaints').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ComplaintResponseModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<ComplaintResponseModel>> getComplaintsByUser(String userId) {
    return _firestore
        .collection('complaints')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ComplaintResponseModel.fromFirestore(doc))
            .toList());
  }

  Future<void> responseComplaint(String complaintId, String response) async {
    await _firestore.collection('complaints').doc(complaintId).update({
      'response': response,
      'status': 'done',
    });
  }
}
