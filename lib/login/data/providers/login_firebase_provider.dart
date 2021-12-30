import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginFirebaseProvider {
  LoginFirebaseProvider({
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  Future<void> loginWithGoogle() async {
    final googleSignInAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
  }

  Stream<User?> isLoggedIn() {
    return firebaseAuth.authStateChanges();
  }
}
