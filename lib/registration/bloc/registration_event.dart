part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationDetailRequested extends RegistrationEvent {
  const RegistrationDetailRequested({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
  final String uid;
}

class RegistrationDetailUpdated extends RegistrationEvent {
  const RegistrationDetailUpdated({
    required this.user,
  });
  final AppUser user;
  @override
  List<Object> get props => [user];
}
