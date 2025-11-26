part of 'authentiction_bloc.dart';

@immutable
sealed class AuthentictionEvent {}

class RegisterUserEvent extends AuthentictionEvent {
  final String name;
  final String email;
  final String password;

  RegisterUserEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginEvent extends AuthentictionEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}
