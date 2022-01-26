import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat/conversation/data/models/message.dart';
import 'package:flutter_chat/message/data/repository/message_repository.dart';

part 'message_receiver_event.dart';
part 'message_receiver_state.dart';

class MessageReceiverBloc
    extends Bloc<MessageReceiverEvent, MessageReceiverState> {
  final MessageRepository messageRepository;
  late final StreamSubscription? messageStream;

  MessageReceiverBloc({
    required this.messageRepository,
  }) : super(MessageReceiverInitial()) {
    on<MessageRequested>(_onMessageRequestedToState);
    on<MessageReceived>(_onMessageReceivedToState);
  }

  @override
  Future<void> close() {
    messageStream?.cancel();
    return super.close();
  }

  FutureOr<void> _onMessageRequestedToState(
    MessageRequested event,
    Emitter<MessageReceiverState> emit,
  ) {
    try {
      emit(MessageLoadInprogress());
      messageStream = messageRepository
          .getMessages(conversationId: event.conversationId)
          .listen((messages) {
        add(MessageReceived(messages: messages));
      });
    } on Exception catch (e, trace) {
      log('Issue while loading message $e $trace');
      emit(MessageLoadFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onMessageReceivedToState(
    MessageReceived event,
    Emitter<MessageReceiverState> emit,
  ) {
    emit(MessageLoadSuccess(messages: event.messages));
  }
}
