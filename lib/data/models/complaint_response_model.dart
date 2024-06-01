import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintResponseModel {
  final String id;
  final String userId;
  final String complaint;
  final String response;
  final String status;
  final Timestamp timestamp;

  ComplaintResponseModel({
    required this.id,
    required this.userId,
    required this.complaint,
    required this.response,
    required this.status,
    required this.timestamp,
  });

  factory ComplaintResponseModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ComplaintResponseModel(
      id: doc.id, // Mengambil ID dokumen dari Firestore
      userId: data['userId'],
      complaint: data['complaint'],
      response: data['response'],
      status: data['status'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'complaint': complaint,
      'response': response,
      'status': status,
      'timestamp': timestamp,
    };
  }
}
