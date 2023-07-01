import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:contacts_repository/contacts_repository_exports.dart';
import 'package:meta/meta.dart';

part 'contacts_options_items_event.dart';
part 'contacts_options_items_state.dart';

class ContactsOptionsItemsBloc extends Bloc<ContactsOptionsItemsEvent, ContactsOptionsItemsRepositoryState> {
  final ContactsOptionsItemsRepository contactsOptionsRepository;

  ContactsOptionsItemsBloc({required this.contactsOptionsRepository}) : super(ContactsOptionsItemsRepositoryState()) {
    on<GetAllContactsOptionsItems>((event, emit) async {
      emit(state.copyWith(status: ContactsOptionsItemsStatus.loading));

      try {
        final contactsOptionsItems = await contactsOptionsRepository.getContactsOptions();
        emit(state.copyWith(status: ContactsOptionsItemsStatus.success, contactsOptionsItem: contactsOptionsItems));
      } catch(error) {
        emit(state.copyWith(status: ContactsOptionsItemsStatus.error, error: error.toString()));
      }
    });
  }
}
