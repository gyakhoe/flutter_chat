import 'package:flutter_chat/login/data/providers/login_firebase_provider.dart';

class LoginRepository {
  LoginRepository({
    required this.loginFirebaseProvider,
  });

  final LoginFirebaseProvider loginFirebaseProvider;

  Future<void> loginWithGoogle() async {
    await loginFirebaseProvider.loginWithGoogle();
  }

  Stream<bool> isLoggedIn() {
    final streamOfUser = loginFirebaseProvider.isLoggedIn();
    return streamOfUser.map((user) => user != null);
  }

  Future<void> logOut() async {
    await loginFirebaseProvider.logOut();
  }
}
