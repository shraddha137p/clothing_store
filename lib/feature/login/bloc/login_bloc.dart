import 'package:clothing_store/feature/login/bloc/login_event.dart';
import 'package:clothing_store/feature/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email.trim(),
          status: LoginStatus.initial,
          errorMessage: '',
        ),
      );
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: event.password.trim(),
          status: LoginStatus.initial,
          errorMessage: '',
        ),
      );
    });

    on<LoginSubmitted>((event, emit) async {
      if (!state.isFormValid) return;

      emit(state.copyWith(status: LoginStatus.loading, errorMessage: ''));

      await Future.delayed(const Duration(seconds: 1));

      if (state.email == 'admin@gmail.com' && state.password == 'Admin@123') {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: 'Invalid email or password',
          ),
        );
      }
    });
  }
}
