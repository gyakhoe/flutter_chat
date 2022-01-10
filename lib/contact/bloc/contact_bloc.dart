import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat/contact/data/repository/contact_repository.dart';
import 'package:flutter_chat/registration/registration.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(
    this.contactRepository,
  ) : super(ContactInitial()) {
    on<ContactListRequested>(_onContactListRequested);
  }

  FutureOr<void> _onContactListRequested(
    ContactListRequested event,
    Emitter<ContactState> emit,
  ) async {
    try {
      emit(ContactLoadInprogress());
      final contacts =
          await contactRepository.getContacts(loginUID: event.loginUID);
      emit(ContactLoadSuccess(contacts: contacts));
    } catch (e) {
      log('Issue while loading contacts ${e.toString()}');
      emit(const ContactLoadFailure(message: 'Unable to load contacts'));
    }
  }
}
