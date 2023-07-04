import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:contacts_repository/contacts_repository_exports.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsRepositoryState> {
  final ContactsRepository contactsRepository;

  ContactsBloc({required this.contactsRepository}) : super(ContactsRepositoryState()) {
    on<GetContactById>(_getContactById);
  }

  void _getContactById(event, emit) async {
    emit(state.copyWith(status: ContactsStatus.fetchingContacts));

    try {
      await contactsRepository.getContactById(contactId: event.contactId);
      emit(state.copyWith(status: ContactsStatus.fetchedContacts));
    } catch (error) {
      emit(state.copyWith(status: ContactsStatus.errorFetchingContacts));
    }
  }
}
