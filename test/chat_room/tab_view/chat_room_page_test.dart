import 'package:authentication_repository/users_exports.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/chat_room/chat_room_exports.dart';

class MockAppAuthBloc extends MockBloc<AppAuthEvent, AppAuthState> implements AppAuthBloc {}

class MockUser extends Mock implements User {}

void main() {
  const logoutButtonKey = Key('homePage_logout_iconButton');
  group('HomePage', () {
    late AppAuthBloc appAuthBloc;
    late User user;

    setUp(() {
      appAuthBloc = MockAppAuthBloc();
      user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appAuthBloc.state).thenReturn(AppAuthState.authenticated(user));
    });

    group('calls', () {
      testWidgets('AppAuthLogoutRequested when logout is pressed', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: appAuthBloc,
            child: const MaterialApp(home: ChatRoomPage()),
          ),
        );
        await tester.tap(find.byKey(logoutButtonKey));
        verify(() => appAuthBloc.add(const AppAuthLogoutRequested())).called(1);
      });
    });

    group('renders', () {
      testWidgets('avatar widget', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: appAuthBloc,
            child: const MaterialApp(home: ChatRoomPage()),
          ),
        );
        expect(find.byType(Avatar), findsOneWidget);
      });

      testWidgets('email address', (tester) async {
        await tester.pumpWidget(
          BlocProvider.value(
            value: appAuthBloc,
            child: const MaterialApp(home: ChatRoomPage()),
          ),
        );
        expect(find.text('test@gmail.com'), findsOneWidget);
      });

      testWidgets('name', (tester) async {
        when(() => user.name).thenReturn('Joe');
        await tester.pumpWidget(
          BlocProvider.value(
            value: appAuthBloc,
            child: const MaterialApp(home: ChatRoomPage()),
          ),
        );
        expect(find.text('Joe'), findsOneWidget);
      });
    });
  });
}
