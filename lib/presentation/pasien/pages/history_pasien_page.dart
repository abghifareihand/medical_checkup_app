import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/presentation/pasien/widgets/history_card.dart';

import '../bloc/get_keluhan_pasien/get_keluhan_pasien_bloc.dart';

class HistoryPasienPage extends StatelessWidget {
  const HistoryPasienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('Riwayat Keluhan'),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      backgroundColor: AppColor.white,
      body: BlocBuilder<GetKeluhanPasienBloc, GetKeluhanPasienState>(
        builder: (context, state) {
          if (state is GetKeluhanPasienLoaded) {
            final data = state.keluhan;

            if (data.isEmpty) {
              return Center(
                child: Text(
                  'Belum ada riwayat keluhan',
                  style: AppFont.blackText.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final keluhan = data[index];
                return HistoryCard(keluhan: keluhan);
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
