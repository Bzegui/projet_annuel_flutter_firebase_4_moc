import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.contactId),
      subtitle: Text(contact.name),
    );
  }
}