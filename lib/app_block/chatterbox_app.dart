import 'package:authentication_repository/authentication_repository_exports.dart';
import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/auth_block/app_auth/app_auth_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/theme.dart';

class ChatterboxApp extends StatelessWidget {
  const ChatterboxApp({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => _authenticationRepository,
        ),
        RepositoryProvider(
          create: (context) => ContactsRepository(
              contactsDataSource: ContactsDataSource()
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppAuthBloc>(
            create: (_) => AppAuthBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
        ],
        child: const ChatterboxAppView(),
      ),
    );
  }
}

class ChatterboxAppView extends StatelessWidget {
  const ChatterboxAppView({super.key});

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