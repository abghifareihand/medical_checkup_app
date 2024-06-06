// Ekstensi DateTimeExt
extension DateTimeExt on DateTime {
  String toFormattedDate() {
    const List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    const List<String> dayNames = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];

    String dayName = dayNames[weekday % 7];
    String day = this.day.toString();
    String month = monthNames[this.month - 1];
    String year = this.year.toString();

    return '$dayName, $day $month $year';
  }
}
