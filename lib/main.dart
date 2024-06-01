import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medical_checkup_app/pages/login_page.dart';
import 'package:medical_checkup_app/pages/login_screen.dart';
import 'package:medical_checkup_app/pages/main_screen.dart';
import 'package:medical_checkup_app/pages/register_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
      // routes: {
      //   '/': (context) => const MainScreen(),
      //   '/login': (context) => const LoginScreen(),
      //   '/register': (context) => const RegisterScreen(),
      // },
      home: const LoginPage(),
    );
  }
}
