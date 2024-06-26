import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/data/datasources/notification_service.dart';
import 'package:medical_checkup_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:medical_checkup_app/presentation/auth/bloc/user/user_bloc.dart';
import 'package:medical_checkup_app/presentation/auth/pages/splash_page.dart';
import 'package:medical_checkup_app/presentation/pasien/bloc/add_keluhan/add_keluhan_bloc.dart';
import 'package:medical_checkup_app/presentation/pasien/bloc/get_keluhan_pasien/get_keluhan_pasien_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/bloc/add_komentar/add_komentar_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/bloc/get_keluhan/get_keluhan_bloc.dart';
import 'firebase_options.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/register/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => AddKeluhanBloc(),
        ),
        BlocProvider(
          create: (context) => GetKeluhanBloc(),
        ),
        BlocProvider(
          create: (context) => GetKeluhanPasienBloc(),
        ),
        BlocProvider(
          create: (context) => AddKomentarBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
