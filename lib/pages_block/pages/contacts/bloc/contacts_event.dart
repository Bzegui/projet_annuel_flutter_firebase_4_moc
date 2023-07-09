part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContactById extends ContactsEvent {

  const GetContactById(this.contactId);

  final String contactId;

  @override
  List<Object> get props => [contactId];
}

class AddContactToContactItemsList extends ContactsEvent {
  final Contact contact;

  const AddContactToContactItemsList(this.contact);

  @override
  List<Object> get props => [contact];
}


