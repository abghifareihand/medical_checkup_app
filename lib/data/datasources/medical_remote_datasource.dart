import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_checkup_app/data/models/checkup_model.dart';
import 'package:medical_checkup_app/data/models/keluhan_model.dart';

class MedicalRemoteDatasource {
  // Create Keluhan
  Future<void> createKeluhan(KeluhanModel keluhan) async {
    await FirebaseFirestore.instance
        .collection('keluhan')
        .doc(keluhan.keluhanId)
        .set(keluhan.toMap());
  }

  // Create Checkup
  Future<void> createCheckup(CheckupModel checkup) async {
    await FirebaseFirestore.instance
        .collection('checkup')
        .doc(checkup.checkupId)
        .set(checkup.toMap());
  }

  // Read Keluhan
  Stream<List<KeluhanModel>> getKeluhan(String pasienId) {
    return FirebaseFirestore.instance
        .collection('keluhan')
        .where('pasienId', isEqualTo: pasienId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => KeluhanModel.fromMap(doc.data()))
            .toList());
  }

  // Read Checkup
  Stream<List<CheckupModel>> getCheckup(String keluhanId) {
    return FirebaseFirestore.instance
        .collection('checkup')
        .where('keluhanId', isEqualTo: keluhanId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CheckupModel.fromMap(doc.data()))
            .toList());
  }
}
