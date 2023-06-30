import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/material.dart';

const defaultContactsOptions = <ContactsOption> [
  ContactsOption(id: "1", icon: Icons.person_add, label: 'Nouveau contact'),
];

@immutable
sealed class ContactsLocalDataSource {}

final class ContactsOptionsDataSource extends ContactsLocalDataSource {
  Future<List<ContactsOption>> getContactsOptions() {
    debugPrint('Getting contacts options from local data source');
    return Future.value(defaultContactsOptions);
  }
}