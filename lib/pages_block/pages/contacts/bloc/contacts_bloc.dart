import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_inputs/form_inputs_exports.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc({
    required ContactsRepository contactsRepository,
  }) : _contactsRepository = contactsRepository, super(const ContactsState()) {
    on<GetContactById>(_onGetContactById);
  }

  final ContactsRepository _contactsRepository;

  void _onGetContactById (
    GetContactById event, Emitter<ContactsState> emit,
  ) async {
    final contactId = ContactId.dirty(event.contactId);

    emit(
      state.copyWith(
        contactsStatus: ContactsStatus.fetchingContacts,
        contactId: contactId,
        isValid: Formz.validate([state.contactId]),
      ),
    );

    try {
      emit(state.copyWith(contactsStatus: ContactsStatus.fetchingContacts));

      final contactStream = _contactsRepository.getContactById(
          contactId: state.contactId.value);

      await emit.forEach(contactStream, onData: (contacts) {
        return state.copyWith(contactsStatus: ContactsStatus.fetchedContacts,
            contacts: contacts);
      });

    } catch (error) {
      emit(state.copyWith(contactsStatus:
      ContactsStatus.errorFetchingContacts));
    }
  }
}
