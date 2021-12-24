import 'package:flutter_chat/login/data/providers/login_firebase_provider.dart';

class LoginRepository {
  LoginRepository({
    required this.loginFirebaseProvider,
  });

  final LoginFirebaseProvider loginFirebaseProvider;

  Future<void> loginWithGoogle() async {
    await loginFirebaseProvider.loginWithGoogle();
  }
}
