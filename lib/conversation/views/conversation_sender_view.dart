import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/conversation/data/models/message.dart';
import 'package:flutter_chat/message/bloc/message_sender_bloc.dart';

class ConversationSenderView extends StatefulWidget {
  final String? conversationId;
  final String senderUID;
  final String receiverUID;

  const ConversationSenderView({
    Key? key,
    this.conversationId,
    required this.senderUID,
    required this.receiverUID,
  }) : super(key: key);

  @override
  State<ConversationSenderView> createState() => _ConversationSenderViewState();
}

class _ConversationSenderViewState extends State<ConversationSenderView> {
  late final TextEditingController messageTextContorller;
  late String message;

  @override
  void initState() {
    super.initState();
    messageTextContorller = TextEditingController();
  }

  @override
  void dispose() {
    messageTextContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: TextField(
            controller: messageTextContorller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<MessageSenderBloc, MessageSenderState>(
            listener: (context, state) {
              if (state is MessageSentSuccess) {
                setState(messageTextContorller.clear);
              }
            },
            builder: (context, state) {
              if (state is MessageSentInprogress) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MessageSentFailure) {
                return const Icon(Icons.error);
              }
              return IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  message = messageTextContorller.text.trim();
                  if (message.isNotEmpty) {
                    BlocProvider.of<MessageSenderBloc>(context).add(
                      MessageSent(
                        message: Message(
                          content: message,
                          conversationId: widget.conversationId ?? '',
                          senderUID: widget.senderUID,
                          receiverUID: widget.receiverUID,
                          timeStamp:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
