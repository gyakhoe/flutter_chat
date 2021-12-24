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
    on<LoginWithGooglePressed>((event, emit) async {
      try {
        emit(LoginInprogress());
        await loginRepository.loginWithGoogle();
        emit(LoginSuccess());
      } catch (any) {
        log('Issue occured while login with google ${any.toString()}');
        emit(LoginFailure());
      }
    });
  }
  final LoginRepository loginRepository;
}
