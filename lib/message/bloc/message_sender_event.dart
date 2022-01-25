part of 'message_sender_bloc.dart';

abstract class MessageSenderEvent extends Equatable {
  const MessageSenderEvent();

  @override
  List<Object> get props => [];
}

class MessageSent extends MessageSenderEvent {
  final Message message;
  const MessageSent({
    required this.message,
  });
}
