import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../models/user.dart';

/// {@template users remote data source}
/// Users remote data source
/// {@endtemplate}

@immutable
sealed class UsersRemoteDataSource {}

final class UsersDataSource extends UsersRemoteDataSource {

  UsersDataSource({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) :  _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final firebase_auth.FirebaseAuth _firebaseAuth;

  /// Creates a new user in [_usersCollection].
  Future<void> addUserToFirestore() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if(currentUser != null) {
        final userDoc = _usersCollection.doc(currentUser.uid);
        final user = currentUser.toUser;

        await userDoc.set({
          'id': user.id,
          'name' : user.name,
          'contactId': user.contactId,
          'email': user.email,
        });

        debugPrint("user successfully added");
      } else {
        debugPrint("Aucun utilisateur actuellement connecté");
      }

    } catch (e) {
      rethrow;
    }
  }
}