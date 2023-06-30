import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

const defaultContactsOptions = <ContactsOption> [
  ContactsOption(icon: Icons.person_add, label: 'Nouveau contact'),
];

class ContactsOptionsDataSource {
  @override
  Future<List<ContactsOption>> getContactsOptions() {
    debugPrint('Getting contacts options from local data source');
    return Future.value(defaultContactsOptions);
  }
}