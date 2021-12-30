part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}

class LoginVerfied extends LoginEvent {}

class LoginStateChanged extends LoginEvent {
  LoginStateChanged({
    required this.isLoggedIn,
  });
  final bool isLoggedIn;
}

class LoginRemoved extends LoginEvent {}
