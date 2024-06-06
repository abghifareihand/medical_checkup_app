import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:medical_checkup_app/data/models/keluhan_response_model.dart';

class KeluhanRemoteDatasource {
  FirebaseAuth auth = FirebaseAuth.instance;
  final keluhanCollection = FirebaseFirestore.instance.collection('keluhan');

  /// Pasien
  Future<Either<String, String>> addKeluhan(
      String pasienId, String pasienName, String keluhan) async {
    try {
      DocumentReference docRef = await keluhanCollection.add({
        'status': 'diproses',
        'pasienId': pasienId,
        'pasienName': pasienName,
        'pasienKeluhan': keluhan,
        'petugasCatatan': '',
        'tanggalDatang': Timestamp.fromDate(DateTime.now()),
        'tanggalKembali': null,
      });
      String documentId = docRef.id;
      await keluhanCollection.doc(documentId).update({
        'id': documentId,
      });
      return const Right('Add Keluhan Berhasil');
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// Petugas
  Stream<List<KeluhanResponseModel>> getKeluhan() {
    try {
      return keluhanCollection.snapshots().map(
            (snapshot) => snapshot.docs
                .map((doc) => KeluhanResponseModel.fromDocumentSnapshot(doc))
                .toList(),
          );
    } catch (e) {
      throw Exception('Gagal mengambil data keluhan: $e');
    }
  }

  /// Petugas
  Future<Either<String, String>> updateKeluhan(
    String keluhanId,
    String catatan,
    DateTime tanggalKembali,
  ) async {
    try {
      await keluhanCollection.doc(keluhanId).update({
        'status': 'sudah direspon',
        'petugasCatatan': catatan,
        'tanggalKembali': Timestamp.fromDate(tanggalKembali),
      });
      return const Right('Update keluhan oleh petugas berhasil');
    } catch (e) {
      return Left(e.toString());
    }
  }


  /// Pasien
  Stream<List<KeluhanResponseModel>> getKeluhanByPasienId(String pasienId) {
    try {
      return keluhanCollection
          .where('pasienId', isEqualTo: pasienId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => KeluhanResponseModel.fromDocumentSnapshot(doc))
                .toList(),
          );
    } catch (e) {
      throw Exception('Gagal mengambil data keluhan: $e');
    }
  }
}
