part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}

class LoginVerfied extends LoginEvent {}

class LoginStateChanged extends LoginEvent {
  final AppUser? user;
  LoginStateChanged({
    this.user,
  });
}

class LoginRemoved extends LoginEvent {}
