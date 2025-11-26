import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:streamsync_lite/features/authentication/repositories/authrepositry.dart';

part 'authentiction_event.dart';
part 'authentiction_state.dart';

class AuthentictionBloc extends Bloc<AuthentictionEvent, AuthentictionState> {
  final Authrepositry authrepositry;
  AuthentictionBloc(this.authrepositry) : super(AuthentictionInitial()) {
    on<AuthentictionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<RegisterUserEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        await authrepositry.registerUser(
          event.name,
          event.email,
          event.password,
        );
        emit(AuthenticationSucces());
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthenticationLoading());
      try {print("Login Bloc called ");

        await authrepositry.LoginUser(event.email, event.password);
print("Login Bloc called ");
        emit(AuthenticationSucces());
      } catch (e) {
        emit(AuthenticationFailure(error: e.toString()));
      }
    });
  }
}
