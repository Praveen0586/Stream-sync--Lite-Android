part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {
  final double progress;

  SplashLoading(this.progress);
}

final class SplashAuthenticated extends SplashState {}

final class SplashUnauthenticated extends SplashState {}

final class SplashError extends SplashState {
  final String message;
  SplashError({required this.message});
}

final class NavigateToNextScreen extends SplashState {}