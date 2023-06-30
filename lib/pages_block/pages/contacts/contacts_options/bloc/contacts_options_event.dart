part of 'contacts_options_bloc.dart';

@immutable
sealed class ContactsOptionsEvent {}

class GetAllContactsOptions extends ContactsOptionsEvent {
  GetAllContactsOptions();
}
