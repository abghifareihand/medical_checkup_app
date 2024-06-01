import 'package:flutter/material.dart';
import 'package:medical_checkup_app/pages/home_pasien_page.dart';
import 'package:medical_checkup_app/pages/home_petugas_page.dart';
import 'package:medical_checkup_app/pages/register_page.dart';

import '../data/datasources/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _authService.login(
                    emailController.text, passwordController.text);
                String? role = await _authService.getUserRole();
                if (!context.mounted) return;
                if (role == 'pasien') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePasienPage()),
                  );
                } else if (role == 'petugas') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePetugasPage()),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegitserPage()),
                );
              },
              child: const Text('Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
