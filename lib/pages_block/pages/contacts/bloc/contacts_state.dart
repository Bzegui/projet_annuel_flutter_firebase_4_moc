part of 'contacts_bloc.dart';

enum ContactsStatus {
  initial,
  fetchingContacts,
  addingContact,
  updatingContact,
  fetchedContacts,
  addedContact,
  updatedContact,
  errorFetchingContacts,
  errorAddingContact,
  errorUpdatingContact
}

@immutable
sealed class ContactsState {}

final class ContactsRepositoryState extends ContactsState {
  final ContactsStatus status;
  final List<Contact> contacts;

  ContactsRepositoryState({
    this.status = ContactsStatus.initial,
    this.contacts = const <Contact>[],
  });

  ContactsRepositoryState copyWith({
    ContactsStatus? status,
    List<Contact>? contacts,
  }) {
    return ContactsRepositoryState(
      status: status ?? this.status,
      contacts: contacts?? this.contacts,
    );
  }
}
