import 'package:cloud_firestore/cloud_firestore.dart';

class KeluhanModel {
  String keluhanId;
  String pasienId;
  String keluhan;
  Timestamp timestamp;
  String status;

  KeluhanModel({required this.keluhanId, required this.pasienId, required this.keluhan, required this.timestamp, required this.status});

  factory KeluhanModel.fromMap(Map<String, dynamic> data) {
    return KeluhanModel(
      keluhanId: data['keluhanId'],
      pasienId: data['pasienId'],
      keluhan: data['keluhan'],
      timestamp: data['timestamp'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'keluhanId': keluhanId,
      'pasienId': pasienId,
      'keluhan': keluhan,
      'timestamp': timestamp,
      'status': status,
    };
  }
}
