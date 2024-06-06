import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/components/custom_button.dart';
import 'package:medical_checkup_app/core/components/custom_dialog.dart';
import 'package:medical_checkup_app/core/components/custom_field.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/date_time_ext.dart';
import 'package:medical_checkup_app/presentation/pasien/bloc/add_keluhan/add_keluhan_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/widgets/text_tile.dart';

class KeluhanPasienPage extends StatefulWidget {
  const KeluhanPasienPage({super.key});

  @override
  State<KeluhanPasienPage> createState() => _KeluhanPasienPageState();
}

class _KeluhanPasienPageState extends State<KeluhanPasienPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keluhanController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 40),
          TextTile(
            label: 'Tanggal Datang',
            text: DateTime.now().toFormattedDate(),
          ),
          CustomField.text(
            controller: _nameController,
            label: 'Nama Pasien',
          ),
          CustomField.comment(
            controller: _keluhanController,
            label: 'Keluhan Pasien',
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          BlocConsumer<AddKeluhanBloc, AddKeluhanState>(
            listener: (context, state) {
              if (state is AddKeluhanLoaded) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      icon: Icons.check_circle,
                      title: 'Berhasil',
                      message:
                          'Anda berhasil menambahkan keluhan, tunggu balasan dari petugas',
                      onDonePressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
                _keluhanController.clear();
              }

              if (state is AddKeluhanError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColor.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  context.read<AddKeluhanBloc>().add(
                        AddKeluhan(
                          pasienId: user!.uid,
                          pasienName: _nameController.text,
                          keluhan: _keluhanController.text,
                        ),
                      );
                },
                text: 'Kirim Keluhan',
                isLoading: state is AddKeluhanLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
