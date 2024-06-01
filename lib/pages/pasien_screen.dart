import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_checkup_app/data/datasources/medical_remote_datasource.dart';
import 'package:medical_checkup_app/data/models/keluhan_model.dart';

class PasienScreen extends StatefulWidget {
  const PasienScreen({super.key});

  @override
  State<PasienScreen> createState() => _PasienScreenState();
}

class _PasienScreenState extends State<PasienScreen> {
  final TextEditingController _keluhanController = TextEditingController();

  Future<void> _submitKeluhan() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String keluhanId =
        FirebaseFirestore.instance.collection('keluhan').doc().id;

    KeluhanModel keluhan = KeluhanModel(
      keluhanId: keluhanId,
      pasienId: uid,
      keluhan: _keluhanController.text,
      timestamp: Timestamp.now(),
      status: 'pending',
    );

    await FirebaseFirestore.instance
        .collection('keluhan')
        .doc(keluhanId)
        .set(keluhan.toMap());
    _keluhanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pasien Dashboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _keluhanController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Keluhan',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submitKeluhan,
            child: const Text('Submit Keluhan'),
          ),
          Expanded(
            child: StreamBuilder<List<KeluhanModel>>(
              stream: MedicalRemoteDatasource().getKeluhan(uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var keluhanList = snapshot.data!;
                return ListView.builder(
                  itemCount: keluhanList.length,
                  itemBuilder: (context, index) {
                    var keluhan = keluhanList[index];
                    return ListTile(
                      title: Text(keluhan.keluhan),
                      subtitle: Text(keluhan.status),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
