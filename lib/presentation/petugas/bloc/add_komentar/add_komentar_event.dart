part of 'add_komentar_bloc.dart';

sealed class AddKomentarEvent {}

class AddKomentar extends AddKomentarEvent {
  final String keluhanId;
  final String catatan;
  final DateTime tanggalKembali;

  AddKomentar({
    required this.keluhanId,
    required this.catatan,
    required this.tanggalKembali,
  });
}
