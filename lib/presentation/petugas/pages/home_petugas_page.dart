import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/core/constants/app_image.dart';
import 'package:medical_checkup_app/presentation/auth/bloc/user/user_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/bloc/get_keluhan/get_keluhan_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/widgets/keluhan_card.dart';

class HomePetugasPage extends StatelessWidget {
  const HomePetugasPage({super.key});

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
                          AppImage.icPetugas,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Keluhan Pasien',
                  style: AppFont.blackText.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                BlocBuilder<GetKeluhanBloc, GetKeluhanState>(
                  builder: (context, state) {
                    if (state is GetKeluhanLoaded) {
                      final data = state.keluhan;

                      if (data.isEmpty) {
                        return Center(
                          child: Text(
                            'Belum ada data keluhan pasien',
                            style: AppFont.blackText.copyWith(
                              fontWeight: light,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final keluhan = data[index];
                          return KeluhanCard(keluhan: keluhan);
                        },
                      );
                    }
                    if (state is GetKeluhanError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
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
