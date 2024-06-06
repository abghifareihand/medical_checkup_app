import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/core/constants/app_image.dart';
import 'package:medical_checkup_app/data/models/berita_response_model.dart';
import 'package:medical_checkup_app/presentation/auth/bloc/user/user_bloc.dart';
import 'package:medical_checkup_app/presentation/pasien/pages/keluhan_pasien_page.dart';
import 'package:medical_checkup_app/presentation/pasien/widgets/berita_tile.dart';

class HomePasienPage extends StatelessWidget {
  const HomePasienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// User Card
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                final user = state.user;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: AppFont.blackText.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                          Text(
                            user.name,
                            style: AppFont.blackText.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                      ClipOval(
                        child: Image.asset(
                          width: 34,
                          height: 34,
                          AppImage.icPasien,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),

          /// Card to Keluhan
          Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apa keluhan\nanda sekarang ?',
                      style: AppFont.whiteText.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KeluhanPasienPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Klik disini',
                        style: AppFont.blackText.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  AppImage.doctor,
                ),
              ],
            ),
          ),

          /// Top doctor
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Berita Terkini',
                  style: AppFont.blackText.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: dummyBeritaList.length,
                  itemBuilder: (context, index) {
                    return BeritaTile(
                      berita: dummyBeritaList[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
