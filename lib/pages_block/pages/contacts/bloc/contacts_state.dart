part of 'contacts_bloc.dart';

enum ContactsStatus {
  initial,
  fetchingContacts,
  fetchedContacts,
  errorFetchingContacts
}

final class ContactsState extends Equatable {
  final ContactId contactId;
  final ContactsStatus contactsStatus;
  final bool isValid;
  final List<Contact> contacts;
  final String? errorMessage;

  const ContactsState({
    this.contactId = const ContactId.pure(),
    this.contactsStatus = ContactsStatus.initial,
    this.isValid = false,
    this.contacts = const <Contact>[],
    this.errorMessage,
  });

  ContactsState copyWith({
    FormzSubmissionStatus? addContactStatus,
    ContactId? contactId,
    ContactsStatus? contactsStatus,
    bool? isValid,
    List<Contact>? contacts,
    String? errorMessage,
  }) {
    return ContactsState(
      contactId: contactId ?? this.contactId,
      contactsStatus: contactsStatus ?? this.contactsStatus,
      isValid: isValid ?? this.isValid,
      contacts: contacts ?? this.contacts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    contactId,
    contactsStatus,
    isValid,
    contacts,
    errorMessage
  ];
}
