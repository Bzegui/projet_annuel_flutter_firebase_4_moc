import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../models/user.dart';

extension FirebaseAuthUserExtension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  User get toUser {
    String shortUID = uid.substring(0, 10);

    return User(id: uid, email: email, contactId: shortUID, name: displayName,
        photo: photoURL);
  }

  Future<void> updateDisplayName(firebase_auth.User? user) async {
    if (user != null) {
      // once we get user object then update user display name using following method
      await user.updateDisplayName(user.displayName);
    }
  }
}