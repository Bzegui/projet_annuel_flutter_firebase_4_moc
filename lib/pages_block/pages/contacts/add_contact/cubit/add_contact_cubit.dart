import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:form_inputs/form_inputs_exports.dart';
import 'package:contacts_repository/contacts_repository_exports.dart';

part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  final ContactsRepository _contactsRepository;

  AddContactCubit(this._contactsRepository) : super(const AddContactState());

  void contactIdChanged(String value) {
    final contactId = ContactId.dirty(value);
    emit(
      state.copyWith(
        contactId: contactId,
        isValid: Formz.validate([
          contactId,
        ]),
      ),
    );
  }

  Future<void> addContactFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _contactsRepository.getContactById(
        contactId: state.contactId.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on AddContactWithContactIdFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
