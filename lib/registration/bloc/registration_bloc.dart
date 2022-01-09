import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat/registration/registration.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;

  RegistrationBloc({
    required this.registrationRepository,
  }) : super(RegistrationInitial()) {
    on<RegistrationDetailRequested>(_onRegistrationDetailRequestedToState);
    on<RegistrationDetailUpdated>(_onRegistrationUpdatedToSgtate);
  }

  FutureOr<void> _onRegistrationDetailRequestedToState(
    RegistrationDetailRequested event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegistrationInprogress());
      final user = await registrationRepository.getUserDetail(uid: event.uid);
      emit(
        user == null
            ? const RegistrationActionFailure(message: 'user not found')
            : RegistrationDetailRequestSuccess(user: user),
      );
    } catch (e) {
      log('Unexpected error occured ${e.toString()}');
      emit(
        const RegistrationActionError(
          message: 'Error occured while searching',
        ),
      );
    }
  }

  FutureOr<void> _onRegistrationUpdatedToSgtate(
    RegistrationDetailUpdated event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegistrationInprogress());
      await registrationRepository.registerUserDetail(user: event.user);
      emit(RegistrationUpdateSuccess(user: event.user));
    } catch (e) {
      log('Error occured while updating user detail ${e.toString()}');
      emit(
        const RegistrationActionError(message: 'error occured while udpating'),
      );
    }
  }
}
