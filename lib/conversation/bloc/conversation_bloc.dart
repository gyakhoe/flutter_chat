import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat/conversation/conversation.dart';
import 'package:flutter_chat/registration/registration.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;
  ConversationBloc({
    required this.conversationRepository,
  }) : super(ConversationInitial()) {
    on<ConversationDetailRequested>(_onConversationDetailRequested);
    on<ConversationCreated>(_onConversationCreated);
  }

  FutureOr<void> _onConversationDetailRequested(
    ConversationDetailRequested event,
    Emitter<ConversationState> emit,
  ) async {
    try {
      emit(ConversationLoadInprogress());
      final conversationDetail = await conversationRepository.getConversation(
        senderUID: event.loginUser.uid,
        receiverUID: event.receiver.uid,
      );

      if (conversationDetail != null) {
        emit(ConversationLoadSuccess(conversation: conversationDetail));
      } else {
        add(
          ConversationCreated(
            conversation: Conversation(
              creator: event.loginUser,
              receiver: event.receiver,
              members: [event.loginUser.uid, event.receiver.uid],
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      log('Issue whiel fetching covnersation detail ${e.toString()}');
      log('Stack trace is ${stackTrace.toString()}');
      emit(
        const ConversationLoadFailure(message: 'Unable to load Conversation'),
      );
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
