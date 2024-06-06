part of 'user_bloc.dart';


sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserResponseModel user;
  UserLoaded({required this.user});
}

final class UserError extends UserState {
  final String message;
  UserError({required this.message});
}