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
    return Padding(
        padding: const EdgeInsets.only(left: 0, top: 15, bottom: 12),
        child: ListTile(
            title: Text(
                contactsOption.label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                ),
            ),
            leading: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  contactsOption.icon,
                  color: const Color(0xFFE0F2F1),
                ),
              ),
            )
        )
    );
  }
}
