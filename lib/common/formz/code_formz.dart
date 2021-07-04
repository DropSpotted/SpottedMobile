import 'package:formz/formz.dart';

enum CodeInputError { empty }

class CodeInput extends FormzInput<String, CodeInputError> {
  const CodeInput.pure() : super.pure('');

  const CodeInput.dirty({String value = ''}) : super.dirty(value);

  @override
  CodeInputError? validator(String? value) {
    print('dasdasdasd');
    if (value != null) {
      final trimmedValue = value.trim();
      if (trimmedValue.length == 6) {
        return null;
      } else {
        return CodeInputError.empty;
      }
    } else {
      return CodeInputError.empty;
    }
  }
}
