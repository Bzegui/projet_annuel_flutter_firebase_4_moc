import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../models/user.dart';

extension FirebaseAuthUserExtension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  User get toUser {
    String shortUID = uid.substring(0, 10);

    return User(id: uid, email: email, contactId: shortUID, name: displayName,
        photo: photoURL);
  }
}