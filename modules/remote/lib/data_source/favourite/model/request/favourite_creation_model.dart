import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/favourite_creation.dart';

part 'favourite_creation_model.g.dart';


@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class FavouriteCreationModel {
  const FavouriteCreationModel({
    required this.geoLocationCoords,
    required this.title,
  });

  factory FavouriteCreationModel.fromJson(Map<String, dynamic> json) => _$FavouriteCreationModelFromJson(json);

  final String geoLocationCoords;
  final String title;

  Map<String, dynamic> toJson() => _$FavouriteCreationModelToJson(this);
}

extension FavouriteCreationExtension on FavouriteCreation {
  FavouriteCreationModel toRemote() {
    return FavouriteCreationModel(
      title: title,
      geoLocationCoords: 'POINT($lat $lon)',
    );
  }
}
