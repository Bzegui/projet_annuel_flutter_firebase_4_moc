import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';
import 'package:projet_annuel_flutter_firebase_4_moc/pages_block/pages/contacts/contacts_exports.dart';

const defaultContactsOptions = <ContactsOptionsItem> [
  ContactsOptionsItem(id: "1", icon: Icons.person_add, label: 'Nouveau contact', navDestination: AddContactPage()),
  ContactsOptionsItem(id: "2", icon: Icons.group_add, label: 'Nouveau groupe', navDestination: AddGroupPage()),
];

@immutable
sealed class ContactsOptionsLocalDataSource {}

final class ContactsOptionsItemsLocalDataSource extends ContactsOptionsLocalDataSource {
  Future<List<ContactsOptionsItem>> getContactsOptions() {
    debugPrint('Getting contacts options from local data source');
    return Future.value(defaultContactsOptions);
  }
}