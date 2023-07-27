import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:users/users_exports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';

Future<void> main() async {
  const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: '/');
  debugPrint('API_BASE_URL: $apiBaseUrl');

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppAuthBlocObserver();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  final usersRemoteDataSource = UsersRemoteDataSource();
  final authenticationRepository = AuthenticationRepository(usersRemoteDataSource: usersRemoteDataSource);
  await authenticationRepository.user.first;

  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
      );
    }).sendPort);

    runApp(ChatterboxApp(authenticationRepository: authenticationRepository));
  }, FirebaseCrashlytics.instance.recordError);
}

