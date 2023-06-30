part of 'contacts_options_bloc.dart';

enum ContactsOptionsStatus {
  initial,
  loading,
  success, error
}

@immutable
sealed class ContactsOptionsState {}

final class ContactsOptionsRepositoryState extends ContactsOptionsState {
  final ContactsOptionsStatus status;
  final List<ContactsOption> contactsOptions;
  final String error;

  ContactsOptionsRepositoryState({
    this.status = ContactsOptionsStatus.initial,
    this.contactsOptions = const [],
    this.error = '',
  });

  ContactsOptionsRepositoryState copyWith({
    ContactsOptionsStatus? status,
    List<ContactsOption>? contactsOptions,
    String? error,
  }) {
    return ContactsOptionsRepositoryState(
      status: status ?? this.status,
      contactsOptions: contactsOptions ?? this.contactsOptions,
      error: error ?? this.error,
    );
  }
}
