import 'package:flutter/material.dart';
import 'package:medical_checkup_app/core/constants/app_font.dart';

class TextTile extends StatelessWidget {
  final String label;
  final String text;
  const TextTile({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppFont.blackText.copyWith(
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            text,
            style: AppFont.blackText.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
