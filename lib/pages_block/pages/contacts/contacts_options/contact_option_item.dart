import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

class ContactOptionItem extends StatelessWidget {
  final ContactsOption contactsOption;

  const ContactOptionItem({
    Key? key,
    required this.contactsOption
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contactsOption.label),
      leading: Icon(contactsOption.icon),
    );
    return const Placeholder();
  }
}
