import 'package:authentication_repository/authentication_repository_imports.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/app_auth/app_auth_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/theme.dart';

import '../auth_routes/auth_routes.dart';

class AppAuth extends StatelessWidget {
  const AppAuth({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppAuthBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppAuthView(),
      ),
    );
  }
}

class AppAuthView extends StatelessWidget {
  const AppAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AppAuthStatus>(
        state: context.select((AppAuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppAuthViewPages,
      ),
    );
  }
}