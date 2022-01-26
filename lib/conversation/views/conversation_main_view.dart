import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/conversation/views/conversation_message_view.dart';

import 'package:flutter_chat/conversation/views/conversation_sender_view.dart';
import 'package:flutter_chat/message/bloc/message_receiver_bloc.dart';
import 'package:flutter_chat/message/bloc/message_sender_bloc.dart';
import 'package:flutter_chat/message/data/provider/message_firebase_provider.dart';
import 'package:flutter_chat/message/data/repository/message_repository.dart';
import 'package:flutter_chat/registration/registration.dart';

class ConversationMainView extends StatelessWidget {
  final AppUser loginUser;
  final AppUser receiver;
  final String conversationId;

  const ConversationMainView({
    Key? key,
    required this.loginUser,
    required this.receiver,
    required this.conversationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const heightOfContainer = 50;
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              heightOfContainer -
              20,
          child: BlocProvider(
            create: (context) => MessageReceiverBloc(
              messageRepository: MessageRepository(
                messageFirebaseProvider: MessageFirebaseProvider(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            )..add(MessageRequested(conversationId: conversationId)),
            child: ConversationMessageView(
              receiver: receiver,
              loginUser: loginUser,
            ),
          ),
        ),
        Container(
          height: heightOfContainer.toDouble(),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: BlocProvider(
              create: (context) => MessageSenderBloc(
                MessageRepository(
                  messageFirebaseProvider: MessageFirebaseProvider(
                    firestore: FirebaseFirestore.instance,
                  ),
                ),
              ),
              child: ConversationSenderView(
                conversationId: conversationId,
                senderUID: loginUser.uid,
                receiverUID: receiver.uid,
              ),
            ),
          ),
        )
      ],
    );
  }
}
