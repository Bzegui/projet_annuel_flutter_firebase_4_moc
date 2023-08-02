import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_inputs/form_inputs_exports.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:users/users_exports.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

/// {@template contacts bloc}
/// {@endtemplate}

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

  /// Add contact user with the provided [contactId].
  /// contact duplicate check (verify with contact unique ID)
  /// if user contact is already present in contacts user items list (by
  /// comparing user contacts unique IDS), emit error state with error status,
  /// if not add user contact to contacts user items list.

  void _onAddContactUserToContactUserItemsList(
      AddContactUserToContactUserItemsList event,
      Emitter<ContactsState> emit,
      ) {
        final newContact = event.user; // new contact to add

        final isDuplicateContact = state.contactUserItemsList.any(
              (contact) => contact.contactId == newContact.contactId,
        );

        if (isDuplicateContact) {
          emit(state.copyWith(contactsStatus:
          ContactsStatus.duplicateContact)); // emit error state

        } else {

          final updatedContactUserItemsList = [...state.contactUserItemsList,
            event.user];

          final updatedContactUserItemsListState = state.copyWith(
            contactUserItemsList: updatedContactUserItemsList,
            contactsStatus: ContactsStatus.fetchedContacts,
          );

          emit(updatedContactUserItemsListState);
        }
      }
}
