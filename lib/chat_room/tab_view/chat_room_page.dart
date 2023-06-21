import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/app_auth/app_auth_exports.dart';

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
        elevation: 0,
        backgroundColor: Colors.white70,
        title: const Text('Chatbox',
          style: TextStyle(color: Colors.black), ),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            color: const Color.fromRGBO(256, 256, 256, 1),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppAuthBloc>().add(const AppAuthLogoutRequested());
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
        backgroundColor: Colors.white70,
      ),
      body: Column( children: [
        //const Padding(
            //padding: EdgeInsets.symmetric(),
        //),

        //Vertical ListView
        Expanded(
          child:  ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 200,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),

              ),
            ],
          ),
        ),
      ],
      ),
    );
  }
}