import 'package:formz/formz.dart';

/// Validation errors for the [ContactId] [FormzInput].
enum ContactIdValidationError {
  /// Generic invalid error.
  invalid,
  empty
}

/// {@template contactId}
/// Form input for an contactId input.
/// {@endtemplate}
class ContactId extends FormzInput<String, ContactIdValidationError> {
  /// {@macro contactId}
  const ContactId.pure() : super.pure('');

  /// {@macro contactId}
  const ContactId.dirty([super.value = '']) : super.dirty();

  static final RegExp _contactIdRegExp = RegExp(
      r'^[a-zA-Z0-9]{1,10}$'
  );

  @override
  ContactIdValidationError? validator(String? value) {
    return _contactIdRegExp.hasMatch(value ?? '')
        ? null
        : ContactIdValidationError.invalid;
  }
}