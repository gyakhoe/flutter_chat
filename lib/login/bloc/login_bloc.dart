import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter_chat/login/login.dart';
import 'package:flutter_chat/registration/registration.dart';
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
    on<LoginRemoved>(_onLoginRemoved);
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
      final authenticateduser = await loginRepository.loginWithGoogle();
      log('the logged in user is ${authenticateduser?.displayName}');
      emit(
        authenticateduser == null
            ? LoginFailure()
            : LoginSuccess(user: authenticateduser),
      );
    } catch (any) {
      log('Issue occured while login with google ${any.toString()}');
      emit(LoginFailure());
    }
  }

  void _onLoginVerified(LoginVerfied event, Emitter<LoginState> emit) {
    try {
      emit(LoginInprogress());
      isLoginStates = loginRepository.getLoggedInUser().listen((user) {
        add(LoginStateChanged(user: user));
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
    final user = event.user;
    emit(user == null ? LoginFailure() : LoginSuccess(user: user));
  }

  FutureOr<void> _onLoginRemoved(
    LoginRemoved event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginInprogress());
      await loginRepository.logOut();
    } catch (e) {
      log('Unexpected error occurred while logout ${e.toString()}');
      LoginFailure();
    }
  }
}
