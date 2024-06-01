import 'package:cloud_firestore/cloud_firestore.dart';

class CheckupModel {
  String checkupId;
  String keluhanId;
  String petugasId;
  String pasienId;
  Timestamp tanggalCheckup;
  String jenisObat;
  String catatanPengobatan;
  String statusPengobatan;

  CheckupModel({
    required this.checkupId,
    required this.keluhanId,
    required this.petugasId,
    required this.pasienId,
    required this.tanggalCheckup,
    required this.jenisObat,
    required this.catatanPengobatan,
    required this.statusPengobatan,
  });

  factory CheckupModel.fromMap(Map<String, dynamic> data) {
    return CheckupModel(
      checkupId: data['checkupId'],
      keluhanId: data['keluhanId'],
      petugasId: data['petugasId'],
      pasienId: data['pasienId'],
      tanggalCheckup: data['tanggalCheckup'],
      jenisObat: data['jenisObat'],
      catatanPengobatan: data['catatanPengobatan'],
      statusPengobatan: data['statusPengobatan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'checkupId': checkupId,
      'keluhanId': keluhanId,
      'petugasId': petugasId,
      'pasienId': pasienId,
      'tanggalCheckup': tanggalCheckup,
      'jenisObat': jenisObat,
      'catatanPengobatan': catatanPengobatan,
      'statusPengobatan': statusPengobatan,
    };
  }
}
