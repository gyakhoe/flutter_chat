part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadInprogress extends ChatState {}

class ChatLoadFailure extends ChatState {
  final String message;
  const ChatLoadFailure({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class ChatLoadSuccess extends ChatState {
  final List<Conversation> chats;
  const ChatLoadSuccess({
    required this.chats,
  });
  @override
  List<Object> get props => [chats];
}
