import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_chat/utilities/keys/message_keys.dart';

class MessageFirebaseProvider {
  final FirebaseFirestore firestore;

  MessageFirebaseProvider({
    required this.firestore,
  });

  Future<void> addMessage({required Map<String, dynamic> messageMap}) async {
    await firestore.collection(MessageKeys.collection).add(messageMap);
  }

  Stream<List<Map<String, dynamic>?>> getMessages({
    required String conversationId,
  }) {
    final querySnapShotStream = firestore
        .collection(MessageKeys.collection)
        .where(MessageKeys.conversationId, isEqualTo: conversationId)
        .orderBy(MessageKeys.timeStamp, descending: true)
        .snapshots();

    return querySnapShotStream.map(
      (event) => event.docs.map((e) => e.data()).toList(),
    );
  }
}
