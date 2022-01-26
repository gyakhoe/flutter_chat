import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat/chat/data/repository/chat_repository.dart';
import 'package:flutter_chat/conversation/conversation.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({
    required this.chatRepository,
  }) : super(ChatInitial()) {
    on<ChatRequested>(_onChatRequestedToState);
  }

  FutureOr<void> _onChatRequestedToState(
    ChatRequested event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoadInprogress());
      final chats = await chatRepository.getChats(loginUID: event.loginUID);
      emit(ChatLoadSuccess(chats: chats));
    } on Exception catch (e, trace) {
      log('Issue occrued while loading chats $e $trace ');
      emit(const ChatLoadFailure(message: 'unable to load chats'));
    }
  }
}
