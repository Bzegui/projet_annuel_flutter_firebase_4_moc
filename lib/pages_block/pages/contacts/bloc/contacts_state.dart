part of 'contacts_bloc.dart';

enum ContactsStatus {
  initial,
  fetchingContacts,
  fetchedContacts,
  errorFetchingContacts
}

class ContactsState extends Equatable {
  final ContactId contactId;
  final ContactsStatus contactsStatus;
  final bool isValid;
  final List<Contact> retrievedContacts;
  final List<Contact> contactsItemsList;
  final String? errorMessage;

  const ContactsState({
    this.contactId = const ContactId.pure(),
    this.contactsStatus = ContactsStatus.initial,
    this.isValid = false,
    this.retrievedContacts = const <Contact>[],
    this.contactsItemsList = const <Contact>[],
    this.errorMessage,
  });

  ContactsState copyWith({
    FormzSubmissionStatus? addContactStatus,
    ContactId? contactId,
    ContactsStatus? contactsStatus,
    bool? isValid,
    List<Contact>? retrievedContacts,
    List<Contact>? contactsItemsList,
    String? errorMessage,
  }) {
    return ContactsState(
      contactId: contactId ?? this.contactId,
      contactsStatus: contactsStatus ?? this.contactsStatus,
      isValid: isValid ?? this.isValid,
      retrievedContacts: retrievedContacts ?? this.retrievedContacts,
      contactsItemsList: contactsItemsList ?? this.contactsItemsList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    contactId,
    contactsStatus,
    isValid,
    retrievedContacts,
    contactsItemsList,
    errorMessage
  ];
}
