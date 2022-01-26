import 'package:flutter_chat/conversation/data/models/message.dart';
import 'package:flutter_chat/message/data/provider/message_firebase_provider.dart';

class MessageRepository {
  final MessageFirebaseProvider messageFirebaseProvider;

  MessageRepository({
    required this.messageFirebaseProvider,
  });

  Future<void> sendMessage({required Message message}) async {
    await messageFirebaseProvider.addMessage(messageMap: message.toMap());
  }

  Stream<List<Message?>> getMessages({required String conversationId}) {
    final messageMapStream =
        messageFirebaseProvider.getMessages(conversationId: conversationId);

    return messageMapStream.map(
      (event) => event.map(
        (e) {
          return e != null ? Message.fromMap(e) : null;
        },
      ).toList(),
    );
  }
}
