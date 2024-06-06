import 'package:flutter/material.dart';
import 'package:medical_checkup_app/core/components/custom_button.dart';
import 'package:medical_checkup_app/core/constants/app_color.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final VoidCallback onDonePressed;

  const CustomDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColor.primary,
              size: 70,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppFont.blackText.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Text(
              message,
              style: AppFont.blackText.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: onDonePressed,
              text: 'Done',
            ),
          ],
        ),
      ),
    );
  }
}

// showDialog(
//                     barrierDismissible: false,
//                     context: context,
//                     builder: (BuildContext context) {
//                       return CustomDialog(
//                         icon: Icons.check_circle,
//                         title: 'Berhasil',
//                         message:
//                             'Anda berhasil menambahkan keluhan, tunggu balasan dari petugas',
//                         onDonePressed: () {
                          // Navigator.of(context).pop();
//                         },
//                       );
//                     },
//                   );