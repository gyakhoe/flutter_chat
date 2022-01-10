part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoadInprogress extends ContactState {}

class ContactLoadFailure extends ContactState {
  final String message;
  const ContactLoadFailure({
    required this.message,
  });
}

class ContactLoadSuccess extends ContactState {
  final List<AppUser> contacts;
  const ContactLoadSuccess({
    required this.contacts,
  });
}
