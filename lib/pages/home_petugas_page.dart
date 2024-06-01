import 'package:flutter/material.dart';
import 'package:medical_checkup_app/data/models/complaint_response_model.dart';
import 'package:medical_checkup_app/pages/login_page.dart';

import '../data/datasources/auth_service.dart';
import '../data/datasources/complaint_service.dart';

class HomePetugasPage extends StatefulWidget {
  const HomePetugasPage({super.key});

  @override
  State<HomePetugasPage> createState() => _HomePetugasPageState();
}

class _HomePetugasPageState extends State<HomePetugasPage> {
  final TextEditingController responseController = TextEditingController();
  final ComplaintService _complaintService = ComplaintService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petugas Dashboard'),
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
      body: StreamBuilder<List<ComplaintResponseModel>>(
        stream: _complaintService.getComplaints(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No complaints found.'));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading complaints.'));
          }

          var complaints = snapshot.data!;
          print('Complaints loaded: ${complaints.length}'); // Debug print
          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              var complaint = complaints[index];
              return ListTile(
                title: Text(complaint.complaint),
                subtitle: Text(
                    'Status: ${complaint.status}\nResponse: ${complaint.response}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Respond to Complaint'),
                        content: TextField(
                          controller: responseController,
                          decoration:
                              const InputDecoration(labelText: 'Response'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await _complaintService.responseComplaint(
                                complaint.id,
                                responseController.text,
                              );
                              responseController.clear();
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
