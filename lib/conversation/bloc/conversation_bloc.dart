import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat/conversation/conversation.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;
  ConversationBloc({
    required this.conversationRepository,
  }) : super(ConversationInitial()) {
    on<ConversataionDetailRequested>(_onConversationDetailRequested);
    on<ConversationCreated>(_onConversationCreated);
  }

  // ! What happens when there is no conversation? will be ok with failure?
  FutureOr<void> _onConversationDetailRequested(
    ConversataionDetailRequested event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      emit(ConversationLoadInprogress());
      final conversationDetail = await conversationRepository.getConversation(
        senderUID: event.loginUID,
        receiverUID: event.receiverUID,
      );
      emit(ConversationLoadSuccess(conversation: conversationDetail));
    } catch (e, stackTrace) {
      log('Issue whiel fetching covnersation detail ${e.toString()}');
      log('Stack trace is ${stackTrace.toString()}');

      emit(const ConversationLoadFailure(message: 'Unable to load Contacts'));
    }
  }

  FutureOr<void> _onConversationCreated(
    ConversationCreated event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      emit(ConversationCreationInprogress());

      final conversationId = await conversationRepository.createConversation(
        conversation: event.conversation,
      );
      emit(ConversationCreationSuccess(conversationId: conversationId));
    } catch (e) {
      log('Issue occured while creating conversation ${e.toString()}');
      emit(
        ConversationCreationFailure(
          message: 'Unable to create new conversation ${e.toString()}',
        ),
      );
    }
  }
}
