import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: ChatRoomPage());

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Align(
          alignment: Alignment(0, -1 / 3),
          child: Text("chat page")
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
            Icons.chat,
            color: Color(0xFFE0F2F1),
        ),
        onPressed: () => _onNewChatCreated(context),
      ),
    );
  }

  void _onNewChatCreated(BuildContext context) {

  }
}


