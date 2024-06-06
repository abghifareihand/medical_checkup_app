part of 'add_keluhan_bloc.dart';

sealed class AddKeluhanEvent {}

class AddKeluhan extends AddKeluhanEvent {
  final String pasienId;
  final String pasienName;
  final String keluhan;

  AddKeluhan({
    required this.pasienId,
    required this.pasienName,
    required this.keluhan,
  });
}
