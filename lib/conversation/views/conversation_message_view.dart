import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat/conversation/data/models/message.dart';
import 'package:flutter_chat/message/bloc/message_receiver_bloc.dart';
import 'package:flutter_chat/registration/registration.dart';

class ConversationMessageView extends StatelessWidget {
  final AppUser loginUser;
  final AppUser receiver;

  const ConversationMessageView({
    Key? key,
    required this.loginUser,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<MessageReceiverBloc, MessageReceiverState>(
        builder: (context, state) {
          if (state is MessageLoadInprogress) {
            return const CircularProgressIndicator();
          } else if (state is MessageLoadFailure) {
            return Text('Unable to fetch Message ${state.message}');
          } else if (state is MessageLoadSuccess) {
            return _MessageListBuilder(
              messages: state.messages,
              loginUID: loginUser.uid,
            );
          }
          return Text(state.runtimeType.toString());
        },
      ),
    );
  }
}

class _MessageListBuilder extends StatelessWidget {
  final String loginUID;
  final List<Message?> messages;
  const _MessageListBuilder({
    Key? key,
    required this.loginUID,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      reverse: true,
      itemBuilder: (BuildContext context, int index) {
        final message = messages.elementAt(index);
        return _MessageBody(
          isMine: message?.senderUID == loginUID,
          message: message,
        );
      },
    );
  }
}

class _MessageBody extends StatelessWidget {
  final bool isMine;
  final Message? message;

  const _MessageBody({
    Key? key,
    required this.isMine,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isMine ? Colors.blueGrey : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Text(
          message?.content ?? '',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
