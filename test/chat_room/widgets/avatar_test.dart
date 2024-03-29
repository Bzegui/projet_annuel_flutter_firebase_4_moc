// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/chat_room/chat_room_exports.dart';

void main() {
  const imageUrl = 'https://www.fnordware.com/superpng/pngtest16rgba.png';
  group('Avatar', () {
    setUpAll(() => HttpOverrides.global = null);

    testWidgets('renders CircleAvatar', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Avatar()));
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('has correct radius', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Avatar()));
      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.radius, 48);
    });

    testWidgets('renders backgroundImage if photo is not null', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Avatar(photo: imageUrl)));
      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.backgroundImage, isNotNull);
      await tester.pumpAndSettle();
    });

    testWidgets('renders icon if photo is null', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Avatar()));
      final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(avatar.backgroundImage, isNull);
      final icon = avatar.child! as Icon;
      expect(icon.icon, Icons.person_outline);
      expect(icon.size, 48);
    });
  });
}
