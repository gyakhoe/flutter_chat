part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationUpdateSuccess extends RegistrationState {
  final AppUser user;
  const RegistrationUpdateSuccess({
    required this.user,
  });
}

class RegistrationDetailRequestSuccess extends RegistrationState {
  final AppUser user;
  const RegistrationDetailRequestSuccess({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class RegistrationActionFailure extends RegistrationState {
  final String message;
  const RegistrationActionFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class RegistrationActionError extends RegistrationState {
  final String message;
  const RegistrationActionError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class RegistrationInprogress extends RegistrationState {}
