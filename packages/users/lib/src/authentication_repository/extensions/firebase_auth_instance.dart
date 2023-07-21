import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

final firebase_auth.FirebaseAuth firebaseAuthInstance =
    firebase_auth.FirebaseAuth.instance;

/// Returns the current Firebase user.
firebase_auth.User? getCurrentUser() {
  return firebaseAuthInstance.currentUser;
}