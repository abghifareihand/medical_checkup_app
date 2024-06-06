import 'package:flutter/material.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';
import 'package:medical_checkup_app/core/constants/date_time_ext.dart';
import 'package:medical_checkup_app/data/models/keluhan_response_model.dart';

import '../pages/history_pasien_detail_page.dart';

class HistoryCard extends StatelessWidget {
  final KeluhanResponseModel keluhan;
  const HistoryCard({
    super.key,
    required this.keluhan,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.grey.withOpacity(0.5),
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
            const SizedBox(height: 8),
            Text(
              'Keluhan :',
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
          ],
        ),
      ),
    );
  }
}
