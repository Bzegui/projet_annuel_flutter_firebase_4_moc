import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: ContactsPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
          alignment: Alignment(0, -1 / 3),
          child: Text("contacts page")
      ),
    );
  }
}

