import 'package:flutter/material.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/login/login_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/chat_room/chat_room_page.dart';
//import 'package:projet_annuel_flutter_firebase_4_moc/navigation_tabs_block/tabs/tab_views/chat_room/chat_room_exports.dart';

void main() {
  group('onGenerateAppViewPages', () {
    test('returns [ChatRoomPage] when authenticated', () {
      expect(
        onGenerateAppAuthViewPages(AppAuthStatus.authenticated, []),
        [
          isA<MaterialPage<void>>().having(
                (p) => p.child,
            'child',
            isA<ChatRoomPage>(),
          )
        ],
      );
    });

    test('returns [LoginPage] when unauthenticated', () {
      expect(
        onGenerateAppAuthViewPages(AppAuthStatus.unauthenticated, []),
        [
          isA<MaterialPage<void>>().having(
                (p) => p.child,
            'child',
            isA<LoginPage>(),
          )
        ],
      );
    });
  });
}
