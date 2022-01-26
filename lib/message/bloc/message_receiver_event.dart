part of 'message_receiver_bloc.dart';

abstract class MessageReceiverEvent extends Equatable {
  const MessageReceiverEvent();

  @override
  List<Object> get props => [];
}

class MessageRequested extends MessageReceiverEvent {
  final String conversationId;
  const MessageRequested({
    required this.conversationId,
  });
}

class MessageReceived extends MessageReceiverEvent {
  final List<Message?> messages;
  const MessageReceived({
    required this.messages,
  });
}
