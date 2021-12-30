part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginRemoveSuccess extends LoginState {}

class LoginInprogress extends LoginState {}

class LoginFailure extends LoginState {}
