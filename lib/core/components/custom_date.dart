import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Gunakan intl untuk memformat tanggal
import 'package:medical_checkup_app/core/constants/date_time_ext.dart';

import '../constants/app_color.dart';
import '../constants/app_font.dart';

class CustomDate extends StatefulWidget {
  final String label;
  final DateTime? initialDate; // Ubah tipe data menjadi DateTime nullable
  final ValueChanged<DateTime?> onDateChanged;

  const CustomDate({
    Key? key,
    required this.label,
    this.initialDate, // Ubah tipe data menjadi DateTime nullable
    required this.onDateChanged,
  }) : super(key: key);

  @override
  _CustomDateState createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  late DateTime? _selectedDate; // Ubah tipe data menjadi DateTime nullable

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate; // Menggunakan widget.initialDate
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          DateTime.now(), // Gunakan DateTime.now() jika _selectedDate null
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: AppFont.blackText.copyWith(
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColor.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: AppColor.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColor.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                suffixIcon: InkWell(
                  onTap: () => _selectDate(context),
                  child: const Icon(
                    Icons.calendar_today,
                    color: AppColor.primary, // Warna ikon kalender
                  ),
                ),
              ),
              child: Text(
                _selectedDate?.toFormattedDate() ?? 'Pilih Tanggal',
                style: AppFont.blackText.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
