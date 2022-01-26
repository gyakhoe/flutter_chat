import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_chat/utilities/keys/conversation_keys.dart';

class ChatFirebaseProvider {
  final FirebaseFirestore firestore;

  ChatFirebaseProvider({
    required this.firestore,
  });

  Future<List<Map<String, dynamic>>> getChats({
    required String loginUID,
  }) async {
    final querySnap = await firestore
        .collection(ConversationKey.collectionName)
        .where(ConversationKey.members, arrayContains: loginUID)
        .get();
    return querySnap.docs.map((e) => e.data()).toList();
  }
}
