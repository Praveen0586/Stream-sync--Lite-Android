import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamsync_lite/features/splash/repositories/splashrepo.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Splashrepo splashrepo;
  SplashCubit(this.splashrepo) : super(SplashInitial()) {
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
      if (await splashrepo.isUserLoggedIn()) {
        emit(UserAlreadyLogined());
      } else {
        emit(SplashLoading(0.9));

        emit(SplashLoading(1.0));

        emit(NavigateToNextScreen());
      }
    } catch (e) {
      emit(SplashError(message: e.toString()));
    }
  }
}
