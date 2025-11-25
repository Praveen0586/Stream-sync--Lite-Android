import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      // Step 1: Load configuration (0-30%)
      emit(SplashLoading(0.0));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SplashLoading(0.3));

      // Step 2: Check authentication (30-60%)
      await Future.delayed(const Duration(milliseconds: 1000));

      emit(SplashLoading(0.6));
      // await Future.delayed(const Duration(milliseconds: 1000));
      emit(SplashLoading(0.7));
      // await Future.delayed(const Duration(milliseconds: 1000));
      emit(SplashLoading(0.8));
      // await Future.delayed(const Duration(milliseconds: 1000));
      emit(SplashLoading(0.9));

      // Step 3: Load user data (60-100%)

      emit(SplashLoading(1.0));
      emit(NavigateToNextScreen());
      // Navigate based on authentication
    } catch (e) {
      emit(SplashError(message: e.toString()));
    }
  }
}
