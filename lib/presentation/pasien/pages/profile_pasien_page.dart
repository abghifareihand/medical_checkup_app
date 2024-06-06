import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/components/custom_button.dart';
import 'package:medical_checkup_app/core/components/spaces.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/presentation/auth/bloc/user/user_bloc.dart';
import '../../../core/constants/app_image.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/pages/login_page.dart';

class ProfilePasienPage extends StatelessWidget {
  const ProfilePasienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                final user = state.user;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      Image.asset(
                        width: 100,
                        height: 100,
                        AppImage.icPasien,
                      ),
                      const SpaceHeight(16),
                      Text(
                        user.name,
                        style: AppFont.blackText.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      Text(
                        user.email,
                        style: AppFont.blackText.copyWith(
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        user.role,
                        style: AppFont.blackText.copyWith(
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          const SpaceHeight(20),
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutLoaded) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              }

              if (state is LogoutError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(Logout());
                },
                text: 'Logout',
                isLoading: state is LogoutLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
