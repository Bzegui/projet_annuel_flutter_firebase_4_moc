import 'package:formz/formz.dart';

/// Validation errors for the [ContactId] [FormzInput].
enum ContactIdValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template contactId}
/// Form input for an contactId input.
/// {@endtemplate}
class ContactId extends FormzInput<String, ContactIdValidationError> {
  /// {@macro contactId}
  const ContactId.pure() : super.pure('');

  /// {@macro contactId}
  const ContactId.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9]*$',
  );

  @override
  ContactIdValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : ContactIdValidationError.invalid;
  }
}