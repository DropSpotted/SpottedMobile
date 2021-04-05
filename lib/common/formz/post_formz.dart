import 'package:formz/formz.dart';

enum PostInputError { empty, toManyCharacters }

class PostInput extends FormzInput<String, PostInputError> {
  const PostInput.pure() : super.pure('');

  const PostInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PostInputError? validator(String? value) {
    if (value != null) {
      final trimmedValue = value.trim();
      if (trimmedValue.isEmpty) {
        return PostInputError.empty;
      } else if (trimmedValue.length > 200) {
        return PostInputError.toManyCharacters;
      } else {
        return null;
      }
    } else {
      return PostInputError.empty;
    }
  }
}
