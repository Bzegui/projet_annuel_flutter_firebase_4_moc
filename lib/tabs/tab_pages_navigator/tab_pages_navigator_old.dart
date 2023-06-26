import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs/tab_views/chat_room/chat_room_exports.dart';
import '../../app_auth/bloc/app_auth_bloc.dart';

class TabPagesNavigator extends StatefulWidget {
  const TabPagesNavigator({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: TabPagesNavigator());

  @override
  State<TabPagesNavigator> createState() => _TabPagesNavigatorState();
}

class _TabPagesNavigatorState extends State<TabPagesNavigator> {
  int _currentIndex = 0;
  final _tabs = const [
    ChatRoomPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppAuthBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(user.email ?? '', textAlign: TextAlign.center,),
          ),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppAuthBloc>().add(const AppAuthLogoutRequested());
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    debugPrint('current index $_currentIndex');
  }
}
