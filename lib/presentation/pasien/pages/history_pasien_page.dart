import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/presentation/pasien/pages/history_pasien_detail_page.dart';

import '../bloc/get_keluhan_pasien/get_keluhan_pasien_bloc.dart';

class HistoryPasienPage extends StatelessWidget {
  const HistoryPasienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<GetKeluhanPasienBloc, GetKeluhanPasienState>(
        builder: (context, state) {
          if (state is GetKeluhanPasienLoaded) {
            final data = state.keluhan;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final keluhan = data[index];
                return ListTile(
                  title: Text(keluhan.pasienKeluhan),
                  subtitle: keluhan.status == 'diproses'
                      ? Text(
                          keluhan.status,
                          style: AppFont.redText,
                        )
                      : Text(keluhan.petugasCatatan),
                  onTap: keluhan.status == 'diproses'
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HistoryPasienDetailPage(keluhan: keluhan),
                            ),
                          );
                        },
                );
              },
            );
          }
          if (state is GetKeluhanPasienError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
