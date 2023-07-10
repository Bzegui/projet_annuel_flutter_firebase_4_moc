part of 'contacts_options_items_bloc.dart';

@immutable
sealed class ContactsOptionsItemsEvent {}

class GetAllContactsOptionsItems extends ContactsOptionsItemsEvent {
  GetAllContactsOptionsItems();
}
