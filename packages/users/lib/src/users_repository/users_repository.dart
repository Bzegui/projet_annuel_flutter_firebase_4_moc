import '../../users_exports.dart';

class UsersRepository {
  UsersRemoteDataSource usersRemoteDataSource;

  UsersRepository({required this.usersRemoteDataSource});

  /// Get user with the provided [contactId].
  ///
  /// Throws a [] if an exception occurs.
  Stream<List<User>> getContactUserById({required String contactId}) {
    return usersRemoteDataSource.getContactUserById(contactId);
  }
}