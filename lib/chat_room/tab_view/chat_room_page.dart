import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/app_auth/app_auth_imports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/app_auth/app_auth_imports.dart';

import '../widgets/avatar.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ChatRoomPage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppAuthBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppAuthBloc>().add(const AppAuthLogoutRequested());
            },
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photo),
            const SizedBox(height: 4),
            Text(user.email ?? '', style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(user.name ?? '', style: textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}