import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_checkup_app/data/models/complaint_response_model.dart';
import 'package:medical_checkup_app/pages/login_page.dart';

import '../data/datasources/auth_service.dart';
import '../data/datasources/complaint_service.dart';

class HomePasienPage extends StatefulWidget {
  const HomePasienPage({super.key});

  @override
  State<HomePasienPage> createState() => _HomePasienPageState();
}

class _HomePasienPageState extends State<HomePasienPage> {
  final TextEditingController complaintController = TextEditingController();
  final ComplaintService _complaintService = ComplaintService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pasien Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: complaintController,
              decoration: const InputDecoration(labelText: 'Keluhan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String uid = FirebaseAuth.instance.currentUser!.uid;
                await _complaintService.submitComplaint(
                  uid,
                  complaintController.text,
                );
                complaintController.clear();
              },
              child: const Text('Submit Keluhan'),
            ),
            Expanded(
              child: StreamBuilder<List<ComplaintResponseModel>>(
                stream: _complaintService.getComplaintsByUser(userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading complaints.'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No complaints found.'));
                  }

                  var complaints = snapshot.data!;
                  return ListView.builder(
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      var complaint = complaints[index];
                      return ListTile(
                        title: Text(complaint.complaint),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Status: ${complaint.status}\nResponse: ${complaint.response}'),
                            Text(
                                'Date: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(complaint.timestamp.toDate())}'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
