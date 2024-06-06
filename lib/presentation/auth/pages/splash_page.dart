import 'package:flutter/material.dart';
import 'package:medical_checkup_app/core/components/spaces.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/core/constants/app_image.dart';
import 'package:medical_checkup_app/data/datasources/auth_local_datasource.dart';
import 'package:medical_checkup_app/presentation/auth/pages/login_page.dart';
import 'package:medical_checkup_app/presentation/pasien/pages/dashboard_pasien_page.dart';
import 'package:medical_checkup_app/presentation/petugas/pages/dashboard_petugas_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await AuthLocalDatasource().isLogin();
    if (isLoggedIn) {
      String role = await AuthLocalDatasource().getRole();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => role == 'pasien'
              ? const DashboardPasienPage()
              : const DashboardPetugasPage(),
        ),
      );
    } else {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImage.logo,
              width: 150,
              height: 150,
            ),
            const SpaceHeight(20.0),
            Text(
              'Medical App',
              style: AppFont.blackText.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
