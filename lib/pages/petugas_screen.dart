import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_checkup_app/data/models/keluhan_model.dart';
import 'package:medical_checkup_app/pages/petugas_keluhan_detail_screen.dart';

class PetugasScreen extends StatelessWidget {
  const PetugasScreen({super.key});

  Future<String> getPasienName(String pasienId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(pasienId)
        .get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      return userData['name'] as String;
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petugas Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('keluhan').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var keluhanDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: keluhanDocs.length,
            itemBuilder: (context, index) {
              var keluhanData =
                  keluhanDocs[index].data() as Map<String, dynamic>;
              var keluhan = KeluhanModel.fromMap(keluhanData);
              return FutureBuilder<String>(
                  future: getPasienName(keluhan.pasienId),
                  builder: (context, pasienSnapshot) {
                    if (!pasienSnapshot.hasData) {
                      return const ListTile(
                        title: Text('Loading...'),
                        subtitle: Text('Loading...'),
                      );
                    }
                    return ListTile(
                      title: Text(keluhan.keluhan),
                      subtitle: Text(
                          'Pasien: ${pasienSnapshot.data}, Status: ${keluhan.status}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PetugasKeluhanDetailScreen(keluhan: keluhan),
                          ),
                        );
                      },
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
