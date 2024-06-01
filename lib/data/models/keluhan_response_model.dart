import 'package:cloud_firestore/cloud_firestore.dart';

class KeluhanResponseModel {
  final String id;
  final String pasienId;
  final String keluhan;
  final String komentar;
  final String status;
  final Timestamp timedate;

  KeluhanResponseModel({
    required this.id,
    required this.pasienId,
    required this.keluhan,
    required this.komentar,
    required this.status,
    required this.timedate,
  });

  factory KeluhanResponseModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return KeluhanResponseModel(
      id: doc.id,
      pasienId: data['pasienId'],
      keluhan: data['keluhan'],
      komentar: data['komentar'],
      status: data['status'],
      timedate: data['timedate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pasienId': pasienId,
      'keluhan': keluhan,
      'komentar': komentar,
      'status': status,
      'timedate': timedate,
    };
  }
}
