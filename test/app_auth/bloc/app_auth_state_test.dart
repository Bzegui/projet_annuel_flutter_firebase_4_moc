// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';

class MockUser extends Mock implements User {}

void main() {
  group('AppAuthState', () {
    group('unauthenticated', () {
      test('has correct status', () {
        final state = AppAuthState.unauthenticated();
        expect(state.status, AppAuthStatus.unauthenticated);
        expect(state.user, User.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final user = MockUser();
        final state = AppAuthState.authenticated(user);
        expect(state.status, AppAuthStatus.authenticated);
        expect(state.user, user);
      });
    });
  });
}
