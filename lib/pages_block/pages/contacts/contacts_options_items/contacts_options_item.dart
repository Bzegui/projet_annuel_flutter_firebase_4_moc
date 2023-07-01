import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

import '../add_contact/add_contact_page.dart';

class ContactOptionsItems extends StatelessWidget {
  final ContactsOptionsItem contactsOptionsItem;

  const ContactOptionsItems({
    Key? key,
    required this.contactsOptionsItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
          title: Text(contactsOptionsItem.label),
          leading: Icon(contactsOptionsItem.icon),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (routeContext) => contactsOptionsItem.navDestination,
            ));
          }
      );
  }

  void _onContactsOptionsItemNavigationDestination(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (routeContext) => contactsOptionsItem.navDestination,
    ));
  }
}