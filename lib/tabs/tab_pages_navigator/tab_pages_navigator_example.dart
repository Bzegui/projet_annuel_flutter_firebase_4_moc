import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs/tab_views/chat_room/chat_room_exports.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs/tab_views/settings/settings_page.dart';

import '../../app_auth/bloc/app_auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPagesNavigator extends StatefulWidget {
  const TabPagesNavigator({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: TabPagesNavigator());

  @override
  State<TabPagesNavigator> createState() => _TabPagesNavigatorState();
}

TabBar get _tabBar => const TabBar(
  labelColor: Colors.white,
  tabs: <Widget>[
    Tab(
      icon: Icon(Icons.chat_bubble),
      text: ('Chat'),

    ),
    Tab(
      icon: Icon(Icons.settings),
      text: 'Settings',
    ),
  ],
);

class _TabPagesNavigatorState extends State<TabPagesNavigator> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final user = context.select((AppAuthBloc bloc) => bloc.state.user);
    const int tabsCount = 3;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: Colors.indigoAccent, //<-- SEE HERE
              child: _tabBar,
            ),
          ),
          //backgroundColor: Colors.indigo,
        ),
        body: const TabBarView(
          children: <Widget>[
            ChatRoomPage(),
            SettingsPage()
          ],
        ),
      ),
    );
  }
}
