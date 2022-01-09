import 'package:flutter_chat/registration/registration.dart';

class RegistrationRepository {
  RegistrationRepository({
    required this.registrationFirebaseProvider,
  });

  final RegistrationFirebaseProvider registrationFirebaseProvider;

  Future<AppUser?> getUserDetail({required String uid}) async {
    final userMapFromFirebase =
        await registrationFirebaseProvider.getUserDetail(uid: uid);
    return userMapFromFirebase == null
        ? null
        : AppUser.fromMap(userMapFromFirebase);
  }

  Future<void> registerUserDetail({required AppUser user}) async {
    await registrationFirebaseProvider.registerUser(user: user.toMap());
  }
}
