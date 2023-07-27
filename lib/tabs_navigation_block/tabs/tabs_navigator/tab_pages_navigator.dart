import 'package:flutter/material.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/tabs_navigation_block/tabs/tab_views/settings/settings_page_exports.dart';
import 'package:users/users_exports.dart';
import '../../../auth_block/app_auth/app_auth_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../tab_views/chat_room/chat_room_exports.dart';
import '../tab_views/settings/settings_bloc/settings_bloc.dart';

class TabPagesNavigator extends StatefulWidget {
  const TabPagesNavigator({Key? key}) : super(key: key);

  static Page<void> page() =>
      const MaterialPage<void>(child: TabPagesNavigator());

  @override
  State<TabPagesNavigator> createState() => _TabPagesNavigatorState();
}

TabBar get _tabBar =>
    const TabBar(
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
    UsersRemoteDataSource  usersRemoteDataSource = UsersRemoteDataSource();
    final userRepository = UsersRepository(usersRemoteDataSource:usersRemoteDataSource);

    Future<User?> fetchCurrentUser() async {
      if (user != null) {
        User? currentUser = await userRepository.getUserProfile(user.id);
        return currentUser;
      }
      return null;
    }

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
        body: TabBarView(
          children: <Widget>[
            const ChatRoomPage(),
            FutureBuilder<User?>(
              future: fetchCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return BlocProvider<SettingsBloc>(
                    create: (context) => SettingsBloc(
                      UsersRepository(usersRemoteDataSource: UsersRemoteDataSource()),
                    ),
                    child: SettingsPage(currentUser: snapshot.data!),
                  );
                } else {
                  return const Center(child: Text('User not found'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
