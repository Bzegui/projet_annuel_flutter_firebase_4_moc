

part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class GetContactUserById extends ContactsEvent {

  const GetContactUserById(this.contactId);

  final String contactId;

  @override
  List<Object> get props => [contactId];
}

class AddContactUserToContactUserItemsList extends ContactsEvent {
  final User user;

  const AddContactUserToContactUserItemsList(this.user);

  @override
  List<Object> get props => [user];
}

class StartConversation extends ContactsEvent {
  final User otherUser;

  const StartConversation(this.otherUser);

  @override
  List<Object> get props => [otherUser];
}


