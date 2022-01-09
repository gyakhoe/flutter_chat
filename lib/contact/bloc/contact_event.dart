part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactListRequested extends ContactEvent {
  final String loginUID;
  const ContactListRequested({
    required this.loginUID,
  });
}
