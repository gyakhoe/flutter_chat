part of 'message_receiver_bloc.dart';

abstract class MessageReceiverState extends Equatable {
  const MessageReceiverState();

  @override
  List<Object> get props => [];
}

class MessageReceiverInitial extends MessageReceiverState {}

class MessageLoadSuccess extends MessageReceiverState {
  final List<Message?> messages;
  const MessageLoadSuccess({
    required this.messages,
  });
  @override
  List<Object> get props => [messages];
}

class MessageLoadInprogress extends MessageReceiverState {}

class MessageLoadFailure extends MessageReceiverState {
  final String message;
  const MessageLoadFailure({
    required this.message,
  });
}
