part of 'add_komentar_bloc.dart';


sealed class AddKomentarState {}

final class AddKomentarInitial extends AddKomentarState {}

final class AddKomentarLoading extends AddKomentarState {}

final class AddKomentarLoaded extends AddKomentarState {
  final String message;
  AddKomentarLoaded({required this.message});
}

final class AddKomentarError extends AddKomentarState {
  final String message;
  AddKomentarError({required this.message});
}
