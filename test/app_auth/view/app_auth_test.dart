import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/login/login_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/navigation_tabs_block/tabs/tab_views/chat_room/chat_room_exports.dart';

class MockUser extends Mock implements User {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockAppAuthBloc extends MockBloc<AppAuthEvent, AppAuthState> implements AppAuthBloc {}

void main() {
  group('AppAuth', () {
    late AuthenticationRepository authenticationRepository;
    late User user;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      user = MockUser();
      when(() => authenticationRepository.user).thenAnswer(
            (_) => const Stream.empty(),
      );
      when(() => authenticationRepository.currentUser).thenReturn(user);
      when(() => user.isNotEmpty).thenReturn(true);
      when(() => user.isEmpty).thenReturn(false);
      when(() => user.email).thenReturn('test@gmail.com');
    });

    testWidgets('renders AppAuthView', (tester) async {
      await tester.pumpWidget(
        AppAuth(authenticationRepository: authenticationRepository),
      );
      await tester.pump();
      expect(find.byType(AppAuthView), findsOneWidget);
    });
  });

  group('AppAuthView', () {
    late AuthenticationRepository authenticationRepository;
    late AppAuthBloc appAuthBloc;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      appAuthBloc = MockAppAuthBloc();
    });

    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appAuthBloc.state).thenReturn(const AppAuthState.unauthenticated());
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: BlocProvider.value(value: appAuthBloc, child: const AppAuthView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      final user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appAuthBloc.state).thenReturn(AppAuthState.authenticated(user));
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: authenticationRepository,
          child: MaterialApp(
            home: BlocProvider.value(value: appAuthBloc, child: const AppAuthView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ChatRoomPage), findsOneWidget);
    });
  });
}
