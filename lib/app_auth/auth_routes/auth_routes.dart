import 'package:flutter/widgets.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/app_auth/app_auth_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/login/login_exports.dart';
import '../../tabs/tab_pages_navigator/tab_pages_navigator_exports.dart';


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