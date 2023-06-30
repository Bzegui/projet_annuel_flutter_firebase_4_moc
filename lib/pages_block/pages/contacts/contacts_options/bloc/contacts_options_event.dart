part of 'contacts_options_bloc.dart';

@immutable
sealed class ContactsOptionsEvent {}

class GetAllContactsOptions extends ContactsOptionsEvent {
  final int count;

  GetAllContactsOptions(this.count);
}
