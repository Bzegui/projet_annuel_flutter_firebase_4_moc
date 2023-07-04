part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent {}

class GetContactById extends ContactsEvent {
  final String contactId;

  GetContactById({required this.contactId});
}
