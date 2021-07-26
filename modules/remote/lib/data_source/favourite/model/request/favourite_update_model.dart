import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/favourite_update.dart';

part 'favourite_update_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class FavouriteUpdateModel {
  const FavouriteUpdateModel({
    this.title,
  });

  factory FavouriteUpdateModel.fromJson(Map<String, dynamic> json) => _$FavouriteUpdateModelFromJson(json);

  final String? title;

  Map<String, dynamic> toJson() => _$FavouriteUpdateModelToJson(this);
}

extension FavouriteUpdateExtension on FavouriteUpdate {
  FavouriteUpdateModel toRemote() {
    return FavouriteUpdateModel(
      title: title,
    );
  }
}
