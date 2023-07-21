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
  final List<User> retrievedContactUsers;
  final List<User> contactUserItemsList;
  final String? errorMessage;

  const ContactsState({
    this.contactId = const ContactId.pure(),
    this.contactsStatus = ContactsStatus.initial,
    this.isValid = false,
    this.retrievedContactUsers = const <User>[],
    this.contactUserItemsList = const <User>[],
    this.errorMessage,
  });

  ContactsState copyWith({
    FormzSubmissionStatus? addContactStatus,
    ContactId? contactId,
    ContactsStatus? contactsStatus,
    bool? isValid,
    List<User>? retrievedContactUsers,
    List<User>? contactUserItemsList,
    String? errorMessage,
  }) {
    return ContactsState(
      contactId: contactId ?? this.contactId,
      contactsStatus: contactsStatus ?? this.contactsStatus,
      isValid: isValid ?? this.isValid,
      retrievedContactUsers: retrievedContactUsers ?? this.retrievedContactUsers,
      contactUserItemsList: contactUserItemsList ?? this.contactUserItemsList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    contactId,
    contactsStatus,
    isValid,
    retrievedContactUsers,
    contactUserItemsList,
    errorMessage
  ];
}
