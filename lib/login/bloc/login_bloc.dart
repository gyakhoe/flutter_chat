import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_chat/login/login.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.loginRepository,
  }) : super(LoginInitial()) {
    on<LoginWithGooglePressed>(_onLoginWithGoogle);
    on<LoginVerfied>(_onLoginVerified);
    on<LoginStateChanged>(_onLoginstateChanged);
  }

  final LoginRepository loginRepository;
  late StreamSubscription isLoginStates;

  @override
  Future<void> close() {
    isLoginStates.cancel();
    return super.close();
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginInprogress());
      await loginRepository.loginWithGoogle();
      emit(LoginSuccess());
    } catch (any) {
      log('Issue occured while login with google ${any.toString()}');
      emit(LoginFailure());
    }
  }

  void _onLoginVerified(LoginVerfied event, Emitter<LoginState> emit) {
    try {
      emit(LoginInprogress());
      isLoginStates = loginRepository.isLoggedIn().listen((isLoggedIn) {
        add(LoginStateChanged(isLoggedIn: isLoggedIn));
      });
    } catch (e) {
      log('Issue  while checking for authentication state ${e.toString()}');
      emit(LoginFailure());
    }
  }

  FutureOr<void> _onLoginstateChanged(
    LoginStateChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(event.isLoggedIn ? LoginSuccess() : LoginFailure());
  }
}
