import 'package:contacts_repository/contacts_repository_exports.dart';

class ContactsOptionsItemsRepository {
  final ContactsOptionsItemsLocalDataSource contactsOptionsItemsDataSource;

  ContactsOptionsItemsRepository({
    required this.contactsOptionsItemsDataSource
  });

  Future<List<ContactsOptionsItem>> getContactsOptions() async {
    try {
      final contactsOptions = await contactsOptionsItemsDataSource.getContactsOptions();
      return contactsOptions;
    } catch (e) {
      rethrow;
    }
  }
}