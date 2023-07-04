part of 'add_contact_cubit.dart';

final class AddContactState extends Equatable {
  const AddContactState({
    this.contactId = const ContactId.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final ContactId contactId;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    contactId,
    status,
    isValid,
    errorMessage,
  ];

  AddContactState copyWith({
    ContactId? contactId,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return AddContactState(
      contactId: contactId ?? this.contactId,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
