import 'package:flutter/widgets.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/login/login_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tabs_navigator/tab_pages_navigator_exports.dart';

List<Page<dynamic>> onGenerateAppAuthViewPages(
    AppAuthStatus state,
    List<Page<dynamic>> pages,
    ) {
  switch (state) {
    case AppAuthStatus.authenticated:
      return [TabPagesNavigator.page()];
    case AppAuthStatus.unauthenticated:
      return [LoginPage.page()];
  }
}