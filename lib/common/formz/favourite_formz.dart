import 'package:formz/formz.dart';

enum FavouriteInputError { empty }

class FavouriteInput extends FormzInput<String, FavouriteInputError> {
  const FavouriteInput.pure() : super.pure('');

  const FavouriteInput.dirty({String value = ''}) : super.dirty(value);

  @override
  FavouriteInputError? validator(String? value) {
    if (value != null) {
      final trimmedValue = value.trim();
      if (trimmedValue.isNotEmpty) {
        return null;
      } else {
        return FavouriteInputError.empty;
      }
    } else {
      return FavouriteInputError.empty;
    }
  }
}
