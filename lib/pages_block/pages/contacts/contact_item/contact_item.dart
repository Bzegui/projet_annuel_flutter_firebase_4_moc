import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key? key,
    required this.contact,
    this.onTap,
  }) : super(key: key);

  final Contact contact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.contactId),
      subtitle: Text(contact.name),
      leading: Container(
        height: 41,
        width: 41,
        decoration: const BoxDecoration(
          color: Colors.indigoAccent,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.photo_album,
          color: Color(0xFFE0F2F1),
        ),
      ),
      onTap: onTap,
    );
  }
}