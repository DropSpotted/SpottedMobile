import 'package:formz/formz.dart';

enum CodeInputError { empty, toManyCharacters }

class CodeInput extends FormzInput<String, CodeInputError> {
  const CodeInput.pure() : super.pure('');

  const CodeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CodeInputError? validator(String? value) {
    if (value != null) {
      final trimmedValue = value.trim();
      if (trimmedValue.isEmpty) {
        return CodeInputError.empty;
      } else if (trimmedValue.length > 6) {
        return CodeInputError.toManyCharacters;
      } else {
        return null;
      }
    } else {
      return CodeInputError.empty;
    }
  }
}
