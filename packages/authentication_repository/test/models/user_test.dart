// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock-email';

    test('uses value equality', () {
      expect(
        User(email: email, id: id, unique_identifier: ''),
        equals(User(email: email, id: id, unique_identifier: '')),
      );
    });

    test('isEmpty returns true for empty user', () {
      expect(User.empty.isEmpty, isTrue);
    });

    test('isEmpty returns false for non-empty user', () {
      final user = User(email: email, id: id, unique_identifier: '');
      expect(user.isEmpty, isFalse);
    });

    test('isNotEmpty returns false for empty user', () {
      expect(User.empty.isNotEmpty, isFalse);
    });

    test('isNotEmpty returns true for non-empty user', () {
      final user = User(email: email, id: id, unique_identifier: '');
      expect(user.isNotEmpty, isTrue);
    });
  });
}
