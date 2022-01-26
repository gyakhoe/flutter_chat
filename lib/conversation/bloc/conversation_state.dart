part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoadSuccess extends ConversationState {
  final Conversation conversation;
  const ConversationLoadSuccess({
    required this.conversation,
  });
}

class ConversationLoadFailure extends ConversationState {
  final String message;
  const ConversationLoadFailure({
    required this.message,
  });
}

class ConversationLoadInprogress extends ConversationState {}

class ConversationCreationSuccess extends ConversationState {
  final String conversationId;
  const ConversationCreationSuccess({
    required this.conversationId,
  });
}

class ConversationCreationInprogress extends ConversationState {}

class ConversationCreationFailure extends ConversationState {
  final String message;
  const ConversationCreationFailure({
    required this.message,
  });
}
