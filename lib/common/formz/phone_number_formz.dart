import 'package:formz/formz.dart';

enum PhoneNumberInputError { empty, toManyCharacters }

class PhoneNumberInput extends FormzInput<String, PhoneNumberInputError> {
  const PhoneNumberInput.pure() : super.pure('');

  const PhoneNumberInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PhoneNumberInputError? validator(String? value) {
    if (value != null) {
      final trimmedValue = value.trim();
      if (trimmedValue.isEmpty) {
        return PhoneNumberInputError.empty;
      } else if (trimmedValue.length > 9) {
        return PhoneNumberInputError.toManyCharacters;
      } else {
        return null;
      }
    } else {
      return PhoneNumberInputError.empty;
    }
  }
}
