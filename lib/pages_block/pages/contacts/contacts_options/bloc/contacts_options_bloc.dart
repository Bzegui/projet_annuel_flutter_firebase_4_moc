import 'package:bloc/bloc.dart';
import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'contacts_options_event.dart';
part 'contacts_options_state.dart';

class ContactsOptionsBloc extends Bloc<ContactsOptionsEvent, ContactsOptionsRepositoryState> {
  final ContactsOptionsRepository contactsOptionsRepository;

  ContactsOptionsBloc({required this.contactsOptionsRepository}) : super(ContactsOptionsRepositoryState()) {
    on<GetAllContactsOptions>((event, emit) async {
      emit(state.copyWith(status: ContactsOptionsStatus.loading));

      final count = event.count;

      try {
        final contactsOptions = await contactsOptionsRepository.getContactsOptions();
        emit(state.copyWith(status: ContactsOptionsStatus.success, contactsOptions: contactsOptions));
      } catch(error) {
        emit(state.copyWith(status: ContactsOptionsStatus.error, error: error.toString()));
      }
    });
  }
}
