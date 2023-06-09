import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository_imports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/app_auth/app_auth_exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'app_auth/bloc/observer/app_auth_bloc_observer.dart';

//TODO: don't forget to test login and sign up on iOS simulator for iOS app !!!

Future<void> main() async {
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: '/');
  debugPrint('API_BASE_URL: $apiBaseUrl');

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppAuthBlocObserver();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(AppAuth(authenticationRepository: authenticationRepository));
}


