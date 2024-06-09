import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_checkup_app/data/datasources/notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reminder'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('reminders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final reminders = snapshot.data!.docs;

            if (reminders.isEmpty) {
              return const Center(
                child: Text('Belum ada data reminder'),
              );
            }
            return ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                final isActive = reminder['isActive'] ?? false;
                return ListTile(
                  title: Text(
                    reminder['title'],
                  ),
                  subtitle: Text(
                    _formatDateTime(reminder['scheduledDate']),
                  ),
                  trailing: isActive
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                  onTap: () {
                    if (!isActive) {
                      _activateNotification(context, reminder);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

void _activateNotification(
    BuildContext context, DocumentSnapshot reminder) async {
  String title = reminder['title'];
  DateTime scheduledDate = (reminder['scheduledDate'] as Timestamp).toDate();

  // Aktifkan notifikasi dengan waktu yang sudah ada di Firestore
  NotificationService.addScheduleNotifications(
    title: 'Medical App',
    body: title,
    scheduledDate: scheduledDate,
  );

  // Update nilai isActive menjadi true di Firestore
  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('reminders')
      .doc(reminder.id)
      .update({'isActive': true});

  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Reminder activate'),
      backgroundColor: Colors.green,
    ),
  );
}

String _formatDateTime(Timestamp timestamp) {
  // Ubah timestamp menjadi objek DateTime
  DateTime dateTime = timestamp.toDate();

  // Format tanggal sesuai dengan preferensi Anda
  String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  String formattedTime =
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';

  // Gabungkan tanggal dan waktu menjadi satu string
  return '$formattedDate $formattedTime';
}
