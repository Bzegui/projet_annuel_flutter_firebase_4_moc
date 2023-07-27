// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';
import 'package:users/users_exports.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUser extends Mock implements User {}

void main() {
  group('AppAuthBloc', () {
    final user = MockUser();
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.empty(),
      );
      when(
            () => authenticationRepository.currentUser,
      ).thenReturn(User.empty);
    });

    test('initial state is unauthenticated when user is empty', () {
      expect(
        AppAuthBloc(authenticationRepository: authenticationRepository).state,
        AppAuthState.unauthenticated(),
      );
    });

    group('UserChanged', () {
      blocTest<AppAuthBloc, AppAuthState>(
        'emits authenticated when user is not empty',
        setUp: () {
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => authenticationRepository.user).thenAnswer(
                (_) => Stream.value(user),
          );
        },
        build: () => AppAuthBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: AppAuthState.unauthenticated,
        expect: () => [AppAuthState.authenticated(user)],
      );

      blocTest<AppAuthBloc, AppAuthState>(
        'emits unauthenticated when user is empty',
        setUp: () {
          when(() => authenticationRepository.user).thenAnswer(
                (_) => Stream.value(User.empty),
          );
        },
        build: () => AppAuthBloc(
          authenticationRepository: authenticationRepository,
        ),
        expect: () => [AppAuthState.unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AppAuthBloc, AppAuthState>(
        'invokes logOut',
        setUp: () {
          when(
                () => authenticationRepository.logOut(),
          ).thenAnswer((_) async {});
        },
        build: () => AppAuthBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(AppAuthLogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}
