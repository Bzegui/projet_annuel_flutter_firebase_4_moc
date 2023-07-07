part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

final class GetContactById extends ContactsEvent {

  const GetContactById(this.contactId);

  final String contactId;

  @override
  List<Object> get props => [contactId];
}


