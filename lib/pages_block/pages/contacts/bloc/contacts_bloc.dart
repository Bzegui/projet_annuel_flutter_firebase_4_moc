import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_inputs/form_inputs_exports.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:users/users_exports.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc({
    required UsersRepository usersRepository,
  }) : _usersRepository = usersRepository, super(const ContactsState()) {
    on<GetContactUserById>(_onGetContactUserById);
    on<AddContactUserToContactUserItemsList>
      (_onAddContactUserToContactUserItemsList);
  }

  final UsersRepository _usersRepository;

  void _onGetContactUserById (
      GetContactUserById event, Emitter<ContactsState> emit,
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
      final contactStream = _usersRepository.getContactUserById(
          contactId: state.contactId.value);

      emit(state.copyWith(contactsStatus: ContactsStatus.fetchingContacts));

      await emit.forEach(contactStream, onData: (retrievedContactUsers) {
        return state.copyWith(contactsStatus: ContactsStatus.fetchedContacts,
            retrievedContactUsers: retrievedContactUsers);
      });

    } catch (error) {
      emit(state.copyWith(contactsStatus:
      ContactsStatus.errorFetchingContacts));
    }
  }

  void _onAddContactUserToContactUserItemsList(
      AddContactUserToContactUserItemsList event,
      Emitter<ContactsState> emit,
      ) {
    final updatedContactUserItemsList = [...state.contactUserItemsList,
      event.user];
    final updatedContactUserItemsListState = state.copyWith(
      contactUserItemsList: updatedContactUserItemsList,
      contactsStatus: ContactsStatus.fetchedContacts,
    );

    emit(updatedContactUserItemsListState);
  }
}
