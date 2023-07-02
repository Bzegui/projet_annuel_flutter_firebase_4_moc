import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';

Future<void> main() async {
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: '/');
  debugPrint('API_BASE_URL: $apiBaseUrl');

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppAuthBlocObserver();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(ChatterboxApp(authenticationRepository: authenticationRepository));
}


