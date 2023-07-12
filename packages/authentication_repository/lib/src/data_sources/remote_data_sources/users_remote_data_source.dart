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
sealed class UsersRemoteDataSourceFailure implements Exception {}

final class UsersRemoteDataSourceAddUserToFirestoreFailure extends
UsersRemoteDataSourceFailure {
  /// {@macro users_remote_data_source_add_user_to_firestore_failure}
  UsersRemoteDataSourceAddUserToFirestoreFailure([
    this.message = 'can\'t retrieve associated user',
  ]);

  /// The associated error message.
  final String message;
}

final class UsersDataSource extends UsersRemoteDataSource {

  final CollectionReference _usersCollection = FirebaseFirestore.
  instance.collection('users');

  /// Creates a new user in [_usersCollection].
  Future<void> addUserToFirestore() async {
    try {
      final currentUser = getCurrentUser();

      if(currentUser != null) {
        final userDoc = _usersCollection.doc(currentUser.uid);
        final user = currentUser.toUser;

        await userDoc.set({
          'id': user.id,
          'name' : user.name,
          'contactId': user.contactId,
          'email': user.email,
        });

      } else {
        throw UsersRemoteDataSourceAddUserToFirestoreFailure;
      }

    } catch (e) {
      rethrow;
    }
  }
}