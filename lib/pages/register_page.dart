import 'package:flutter/material.dart';
import 'package:medical_checkup_app/pages/home_pasien_page.dart';
import 'package:medical_checkup_app/pages/home_petugas_page.dart';

import '../data/datasources/auth_service.dart';

class RegitserPage extends StatefulWidget {
  const RegitserPage({super.key});

  @override
  State<RegitserPage> createState() => _RegitserPageState();
}

class _RegitserPageState extends State<RegitserPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String selectedRole = 'pasien';

  Future<void> _register() async {
    try {
      await _authService.register(
        nameController.text,
        emailController.text,
        passwordController.text,
        selectedRole,
      );
      if (!mounted) return;
      if (selectedRole == 'pasien') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePasienPage()),
        );
      } else if (selectedRole == 'petugas') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePetugasPage()),
        );
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButton<String>(
              value: selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              items: <String>['pasien', 'petugas']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                await _authService.register(
                  nameController.text,
                  emailController.text,
                  passwordController.text,
                  selectedRole,
                );
                if (selectedRole == 'pasien') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePasienPage()),
                  );
                } else if (selectedRole == 'petugas') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePetugasPage()),
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
