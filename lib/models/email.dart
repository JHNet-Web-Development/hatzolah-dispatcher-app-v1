import 'package:formz/formz.dart';
import 'package:hatzolah_dispatcher_app/utilities/general_helper.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    return Validators.isValidEmail(value!) ? null : EmailValidationError.invalid;
  }
}