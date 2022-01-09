import 'package:flutter_chat/login/data/providers/login_firebase_provider.dart';
import 'package:flutter_chat/registration/registration.dart';

class LoginRepository {
  LoginRepository({
    required this.loginFirebaseProvider,
  });

  final LoginFirebaseProvider loginFirebaseProvider;

  Future<AppUser?> loginWithGoogle() async {
    final firebaseUser = await loginFirebaseProvider.loginWithGoogle();
    return firebaseUser == null
        ? null
        : AppUser(
            uid: firebaseUser.uid,
            displayName: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            photoUrl: firebaseUser.photoURL ?? '',
          );
  }

  Stream<bool> isLoggedIn() {
    final streamOfUser = loginFirebaseProvider.isLoggedIn();
    return streamOfUser.map((user) => user != null);
  }

  Stream<AppUser?> getLoggedInUser() {
    final loggedInUserStream = loginFirebaseProvider.isLoggedIn();
    return loggedInUserStream.map((firebaseuser) {
      if (firebaseuser == null) {
        return null;
      } else {
        return AppUser(
          uid: firebaseuser.uid,
          displayName: firebaseuser.displayName ?? '',
          email: firebaseuser.email ?? '',
          photoUrl: firebaseuser.photoURL ?? '',
        );
      }
    });
  }

  Future<void> logOut() async {
    await loginFirebaseProvider.logOut();
  }
}
