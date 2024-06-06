import 'package:cloud_firestore/cloud_firestore.dart';

class KeluhanResponseModel {
  final String id;
  final String status;
  final String pasienId;
  final String pasienName;
  final String pasienKeluhan;
  final String petugasCatatan;
  final DateTime tanggalDatang;
  final DateTime? tanggalKembali;

  KeluhanResponseModel({
    required this.id,
    required this.status,
    required this.pasienId,
    required this.pasienName,
    required this.pasienKeluhan,
    required this.petugasCatatan,
    required this.tanggalDatang,
    this.tanggalKembali,
  });

  factory KeluhanResponseModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return KeluhanResponseModel(
      id: snapshot.id,
      status: snapshot['status'],
      pasienId: snapshot['pasienId'],
      pasienName: snapshot['pasienName'],
      pasienKeluhan: snapshot['pasienKeluhan'],
      petugasCatatan: snapshot['petugasCatatan'],
      tanggalDatang: snapshot['tanggalDatang'] != null
          ? (snapshot['tanggalDatang'] as Timestamp).toDate()
          : DateTime.now(),
      tanggalKembali: snapshot['tanggalKembali'] != null
          ? (snapshot['tanggalKembali'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'pasienId': pasienId,
      'pasienName': pasienName,
      'pasienKeluhan': pasienKeluhan,
      'petugasCatatan': petugasCatatan,
      'tanggalDatang': tanggalDatang,
      'tanggalKembali': tanggalKembali,
    };
  }
}
