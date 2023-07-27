import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/settings/settings_page_exports.dart';
import 'package:users/users_exports.dart';

void main() {
  testWidgets('Test SettingsPage', (WidgetTester tester) async {
    const user = User(id: '1WTXU9OGSUP0hzW1o7iYc8Lbi7D2');

    await tester.pumpWidget(const MaterialApp(home: SettingsPage(currentUser: user)));

    expect(find.text('First Name'), findsOneWidget);
    expect(find.text('Last Name'), findsOneWidget);
    expect(find.text('Date of Birth'), findsOneWidget);
    expect(find.text('Profile Photo'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}
