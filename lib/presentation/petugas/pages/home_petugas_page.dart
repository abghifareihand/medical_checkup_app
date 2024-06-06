import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/presentation/petugas/bloc/get_keluhan/get_keluhan_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/pages/petugas_detail_page.dart';

class HomePetugasPage extends StatelessWidget {
  const HomePetugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<GetKeluhanBloc, GetKeluhanState>(
        builder: (context, state) {
          if (state is GetKeluhanLoaded) {
            final data = state.keluhan;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final keluhan = data[index];
                return ListTile(
                  title: Text(keluhan.pasienName),
                  subtitle: Text(keluhan.pasienKeluhan),
                  trailing: Text(
                    keluhan.status,
                    style: keluhan.status == 'diproses'
                        ? AppFont.redText
                        : AppFont.greenText,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PetugasDetailPage(keluhan: keluhan),
                      ),
                    );
                  },
                );
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
    );
  }
}
