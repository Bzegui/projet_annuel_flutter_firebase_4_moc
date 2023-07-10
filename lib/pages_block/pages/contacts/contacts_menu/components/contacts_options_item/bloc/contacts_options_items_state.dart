part of 'contacts_options_items_bloc.dart';

enum ContactsOptionsItemsStatus {
  initial,
  loading,
  success,
  error
}

@immutable
sealed class ContactsOptionsItemsState {}

final class ContactsOptionsItemsRepositoryState extends ContactsOptionsItemsState {
  final ContactsOptionsItemsStatus status;
  final List<ContactsOptionsItem> contactsOptionsItem;
  final String error;

  ContactsOptionsItemsRepositoryState({
    this.status = ContactsOptionsItemsStatus.initial,
    this.contactsOptionsItem = const [],
    this.error = '',
  });

  ContactsOptionsItemsRepositoryState copyWith({
    ContactsOptionsItemsStatus? status,
    List<ContactsOptionsItem>? contactsOptionsItem,
    String? error,
  }) {
    return ContactsOptionsItemsRepositoryState(
      status: status ?? this.status,
      contactsOptionsItem: contactsOptionsItem ?? this.contactsOptionsItem,
      error: error ?? this.error,
    );
  }
}
