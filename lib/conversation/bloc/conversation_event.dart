part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class ConversataionDetailRequested extends ConversationEvent {
  final AppUser loginUser;
  final AppUser receiver;
  const ConversataionDetailRequested({
    required this.loginUser,
    required this.receiver,
  });
}

class ConversationCreated extends ConversationEvent {
  final Conversation conversation;
  const ConversationCreated({
    required this.conversation,
  });
}
