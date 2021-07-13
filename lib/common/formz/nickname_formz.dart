import 'package:formz/formz.dart';

enum NicknameInputError { empty, toManyCharacters }

class NicknameInput extends FormzInput<String, NicknameInputError> {
  const NicknameInput.pure() : super.pure('');

  const NicknameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NicknameInputError? validator(String? value) {
    if (value != null) {
      final trimmedValue = value.trim();
      if (trimmedValue.isEmpty) {
        return NicknameInputError.empty;
      } else if (trimmedValue.length > 30) {
        return NicknameInputError.toManyCharacters;
      } else {
        return null;
      }
    } else {
      return NicknameInputError.empty;
    }
  }
}
