import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/contacts_option.dart';
import '../data_sources/local_data_sources/contacts/contacts_options_data_source.dart';

class ContactsOptionsRepository {
  final ContactsOptionsDataSource contactsOptionsDataSource;

  ContactsOptionsRepository({
    required this.contactsOptionsDataSource
  });

  Future<List<ContactsOption>> getContactsOptions() async {
    try {
      final contactsOptions = await contactsOptionsDataSource.getContactsOptions();
      return contactsOptions;
    } catch (e) {
      rethrow;
    }
  }
}