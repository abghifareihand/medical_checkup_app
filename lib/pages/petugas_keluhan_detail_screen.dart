import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_checkup_app/data/models/keluhan_model.dart';

class PetugasKeluhanDetailScreen extends StatefulWidget {
  final KeluhanModel keluhan;
  const PetugasKeluhanDetailScreen({super.key, required this.keluhan});

  @override
  State<PetugasKeluhanDetailScreen> createState() =>
      _PetugasKeluhanDetailScreenState();
}

class _PetugasKeluhanDetailScreenState
    extends State<PetugasKeluhanDetailScreen> {
  final TextEditingController _tanggalCheckupController =
      TextEditingController();
  final TextEditingController _jenisObatController = TextEditingController();
  final TextEditingController _catatanPengobatanController =
      TextEditingController();
  final TextEditingController _statusPengobatanController =
      TextEditingController();

  final TextEditingController _reminderMessageController =
      TextEditingController();
  final TextEditingController _reminderTimeController = TextEditingController();

  Future<void> _submitCheckup() async {
    Timestamp tanggalCheckup =
        Timestamp.fromDate(DateTime.parse(_tanggalCheckupController.text));

    await FirebaseFirestore.instance
        .collection('keluhan')
        .doc(widget.keluhan.keluhanId)
        .update({
      'tanggalCheckup': tanggalCheckup,
      'jenisObat': _jenisObatController.text,
      'catatanPengobatan': _catatanPengobatanController.text,
      'statusPengobatan': _statusPengobatanController.text,
      'status': 'scheduled',
    });

    Navigator.pop(context);
  }

  Future<void> _submitReminder() async {
    Timestamp reminderTime =
        Timestamp.fromDate(DateTime.parse(_reminderTimeController.text));

    String reminderId = FirebaseFirestore.instance.collection('reminders').doc().id;

    await FirebaseFirestore.instance.collection('reminders').doc(reminderId).set({
      'reminderId': reminderId,
      'keluhanId': widget.keluhan.keluhanId,
      'pasienId': widget.keluhan.pasienId,
      'message': _reminderMessageController.text,
      'time': reminderTime,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Keluhan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Keluhan: ${widget.keluhan.keluhan}'),
              TextField(
                controller: _tanggalCheckupController,
                decoration: const InputDecoration(
                    labelText: 'Tanggal Checkup (YYYY-MM-DD)'),
              ),
              TextField(
                controller: _jenisObatController,
                decoration: const InputDecoration(labelText: 'Jenis Obat'),
              ),
              TextField(
                controller: _catatanPengobatanController,
                decoration:
                    const InputDecoration(labelText: 'Catatan Pengobatan'),
              ),
              TextField(
                controller: _statusPengobatanController,
                decoration:
                    const InputDecoration(labelText: 'Status Pengobatan'),
              ),
              ElevatedButton(
                onPressed: _submitCheckup,
                child: const Text('Submit Checkup'),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Tambah Pengingat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _reminderMessageController,
                decoration: const InputDecoration(labelText: 'Pesan Pengingat'),
              ),
              TextField(
                controller: _reminderTimeController,
                decoration: const InputDecoration(
                    labelText: 'Waktu Pengingat (YYYY-MM-DD HH:MM:SS)'),
              ),
              ElevatedButton(
                onPressed: _submitReminder,
                child: const Text('Submit Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
