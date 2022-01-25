part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class ConversataionDetailRequested extends ConversationEvent {
  final String loginUID;
  final String receiverUID;
  const ConversataionDetailRequested({
    required this.loginUID,
    required this.receiverUID,
  });
}

class ConversationCreated extends ConversationEvent {
  final Conversation conversation;
  const ConversationCreated({
    required this.conversation,
  });
}
