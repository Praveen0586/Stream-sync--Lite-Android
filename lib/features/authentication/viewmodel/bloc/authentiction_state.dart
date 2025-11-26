part of 'authentiction_bloc.dart';

@immutable
sealed class AuthentictionState {}

final class AuthentictionInitial extends AuthentictionState {}

class AUthenticationstarted extends AuthentictionState {}

class AuthenticationLoading extends AuthentictionState {}

class AuthenticationSucces extends AuthentictionState {}

final class AuthenticationFailure extends AuthentictionState {
  final String error;

  AuthenticationFailure({required this.error});
}
