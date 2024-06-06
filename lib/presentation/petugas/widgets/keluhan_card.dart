import 'package:flutter/material.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/core/constants/date_time_ext.dart';
import 'package:medical_checkup_app/data/models/keluhan_response_model.dart';
import 'package:medical_checkup_app/presentation/petugas/pages/petugas_detail_page.dart';

class KeluhanCard extends StatelessWidget {
  final KeluhanResponseModel keluhan;
  const KeluhanCard({super.key, required this.keluhan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: keluhan.status == 'diproses'
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetugasDetailPage(keluhan: keluhan),
                ),
              );
            }
          : null,
      child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  keluhan.status == 'diproses' ? AppColor.red : AppColor.green,
              width: 1.0, // Lebar border
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    keluhan.tanggalDatang.toFormattedDate(),
                    style: AppFont.blackText.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    keluhan.status.toUpperCase(),
                    style: keluhan.status == 'diproses'
                        ? AppFont.redText.copyWith(
                            fontWeight: medium,
                          )
                        : AppFont.greenText.copyWith(
                            fontWeight: medium,
                          ),
                  ),
                ],
              ),
              Divider(
                color: AppColor.grey.withOpacity(0.5),
              ),
              Text(
                'Nama Pasien :',
                style: AppFont.blackText.copyWith(
                  fontWeight: medium,
                ),
              ),
              Text(
                keluhan.pasienName,
                style: AppFont.blackText.copyWith(
                  fontWeight: light,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Keluhan Pasien :',
                style: AppFont.blackText.copyWith(
                  fontWeight: medium,
                ),
              ),
              Text(
                keluhan.pasienKeluhan,
                style: AppFont.blackText.copyWith(
                  fontWeight: light,
                ),
              ),
              if (keluhan.tanggalKembali != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Catatan Petugas :',
                  style: AppFont.blackText.copyWith(
                    fontWeight: medium,
                  ),
                ),
                Text(
                  keluhan.petugasCatatan,
                  style: AppFont.blackText.copyWith(
                    fontWeight: light,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tanggal Kembali :',
                  style: AppFont.blackText.copyWith(
                    fontWeight: medium,
                  ),
                ),
                Text(
                  keluhan.tanggalKembali!.toFormattedDate(),
                  style: AppFont.blackText.copyWith(
                    fontWeight: light,
                  ),
                ),
              ],
            ],
          )),
    );
  }
}
