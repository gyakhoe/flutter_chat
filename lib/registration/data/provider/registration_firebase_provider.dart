import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationFirebaseProvider {
  RegistrationFirebaseProvider({
    required this.firestore,
  });

  Future<Map<String, dynamic>?> getUserDetail({required String uid}) async {
    final userQuerySnap = await firestore.collection('users').doc(uid).get();
    return userQuerySnap.data();
  }

  Future<void> registerUser({required Map<String, dynamic> user}) async {
    await firestore.collection('users').doc(user['uid'].toString()).set(user);
  }

  final FirebaseFirestore firestore;
}
