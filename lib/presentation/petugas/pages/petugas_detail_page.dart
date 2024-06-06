import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_checkup_app/core/components/custom_button.dart';
import 'package:medical_checkup_app/core/components/custom_date.dart';
import 'package:medical_checkup_app/core/components/custom_dialog.dart';
import 'package:medical_checkup_app/core/components/custom_field.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/date_time_ext.dart';
import 'package:medical_checkup_app/data/models/keluhan_response_model.dart';
import 'package:medical_checkup_app/presentation/petugas/bloc/add_komentar/add_komentar_bloc.dart';
import 'package:medical_checkup_app/presentation/petugas/widgets/text_tile.dart';

class PetugasDetailPage extends StatefulWidget {
  final KeluhanResponseModel keluhan;
  const PetugasDetailPage({super.key, required this.keluhan});

  @override
  State<PetugasDetailPage> createState() => _PetugasDetailPageState();
}

class _PetugasDetailPageState extends State<PetugasDetailPage> {
  final TextEditingController _catatanController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: const Text('Detail Keluhan Pasien'),
        backgroundColor: AppColor.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextTile(
            label: 'Tanggal Datang',
            text: widget.keluhan.tanggalDatang.toFormattedDate(),
          ),
          TextTile(
            label: 'Keluhan Pasien',
            text: widget.keluhan.pasienKeluhan,
          ),
          CustomDate(
            label: 'Tanggal Harus Kembali',
            initialDate: null,
            onDateChanged: (newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
          CustomField.comment(
            controller: _catatanController,
            label: 'Catatan',
          ),
          const SizedBox(height: 20),
          BlocConsumer<AddKomentarBloc, AddKomentarState>(
            listener: (context, state) {
              if (state is AddKomentarLoaded) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      icon: Icons.check_circle,
                      title: 'Berhasil',
                      message: 'Anda berhasil merespon keluhan dari pasien',
                      onDonePressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
                _catatanController.clear();
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () {
                  context.read<AddKomentarBloc>().add(
                        AddKomentar(
                          keluhanId: widget.keluhan.id,
                          catatan: _catatanController.text,
                          tanggalKembali: _selectedDate!,
                        ),
                      );
                },
                text: 'Respon Keluhan Pasien',
                isLoading: state is AddKomentarLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
