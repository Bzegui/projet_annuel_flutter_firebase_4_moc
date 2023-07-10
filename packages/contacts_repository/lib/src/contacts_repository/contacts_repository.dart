import 'package:contacts_repository/contacts_repository_exports.dart';

/// {@template add_contact_with_contact_id_failure}
/// Thrown during the contact addition process if a failure occurs.
/// {@endtemplate}
class AddContactWithContactIdFailure implements Exception {
  /// {@macro add_contact_with_contact_id_failure}
  const AddContactWithContactIdFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an message
  /// from a cloud firestore code.
  factory AddContactWithContactIdFailure.fromCode(String code) {
    switch (code) {
      case 'contact-not-found':
        return const AddContactWithContactIdFailure(
          'There is no contact existing with this id.',
        );
      default:
        return const AddContactWithContactIdFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class ContactsRepository {
  ContactsDataSource contactsDataSource;

  ContactsRepository({required this.contactsDataSource});

  /// Get contact with the provided [contactId].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Stream<List<Contact>> getContactById({required String contactId}) {
    return contactsDataSource.getContactById(contactId);
  }
}