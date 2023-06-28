import 'package:flutter/material.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/settings/settings_page_exports.dart';
import '../../../auth_block/app_auth/app_auth_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../tab_views/chat_room/chat_room_exports.dart';

class TabPagesNavigator extends StatefulWidget {
  const TabPagesNavigator({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: TabPagesNavigator());

  @override
  State<TabPagesNavigator> createState() => _TabPagesNavigatorState();
}

TabBar get _tabBar => const TabBar(
  labelColor: Color(0xFFE0F2F1),
  indicatorColor: Color(0xFFE0F2F1),
  indicatorWeight: 4,
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
    final user = context.select((AppAuthBloc bloc) => bloc.state.user);
    const int tabsCount = 2;

    return DefaultTabController(
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
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
              color: Colors.indigoAccent, //<-- SEE HERE to mod tab bar color
              child: _tabBar,
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            ChatRoomPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
