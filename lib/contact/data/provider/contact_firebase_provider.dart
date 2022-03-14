import 'package:cloud_firestore/cloud_firestore.dart';

class ContactFirebaseProvider {
  final FirebaseFirestore firestore;

  ContactFirebaseProvider({
    required this.firestore,
  });

  Future<List<Map<String, dynamic>>> getContacts({
    required String loginUID,
  }) async {
    final userQuerySnap = await firestore
        .collection('users')
        .where('uid', isNotEqualTo: loginUID)
        .get();
    return userQuerySnap.docs
        .map((queryDocSnap) => queryDocSnap.data())
        .toList();
  }
}
