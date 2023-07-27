import 'package:users/users_exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// {@template users remote data source}
/// Users remote data source
/// {@endtemplate}

@immutable
sealed class UsersDataSource {}
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

class UsersRemoteDataSource extends UsersDataSource {

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
          'birthDate': user.birthDate,
          'photo': user.photo
        });

      } else {
        throw UsersRemoteDataSourceAddUserToFirestoreFailure;
      }

    } catch (e) {
      rethrow;
    }
  }

  /// {@macro getContactUserById}
  /// use Streams to return a contact (list of unique user) if contactId
  /// matched on database or an empty users list if database snapshot is
  /// empty.
  /// use 'asyncExpand' to transform each element of the initial stream to a new
  /// one. if database snapshot isn't empty, the list of matching users with
  /// provided id is returned, otherwise, an empty list of users is returned.
  Stream<List<User>> getContactUserById(String contactId) {
    try {
      return _usersCollection
          .where('contactId', isEqualTo: contactId)
          .snapshots()
          .asyncExpand((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return Stream.value(snapshot.docs.map((doc) {
            debugPrint("${doc.data()}");
            return User.fromFirestore(doc.data() as Map<String, dynamic>,
                doc.id);
          }).toList());
        } else {
          return Stream.value(<User>[]);
        }
      });
    } catch (error) {
      throw Exception('Failed to get contacts');
    }
  }
}