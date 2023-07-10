import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

class ContactOptionsItems extends StatelessWidget {
  final ContactsOptionsItem contactsOptionsItem;

  const ContactOptionsItems({
    Key? key,
    required this.contactsOptionsItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
              title: Text(
                contactsOptionsItem.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              leading: Container(
                height: 41,
                width: 41,
                decoration: const BoxDecoration(
                  color: Colors.indigoAccent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child:  Icon(
                    contactsOptionsItem.icon,
                    color: const Color(0xFFE0F2F1),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (routeContext) => contactsOptionsItem.navDestination,
                ));
              }
          ),
      );
  }
}