import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/favourite.dart';
import 'package:remote/model/point_model.dart';

part 'favourite_model.g.dart';


@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class FavouriteModel {
  const FavouriteModel({
    required this.id,
    required this.geoLocationCoords,
    required this.title,
    required this.createdAt,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => _$FavouriteModelFromJson(json);

  final String id;
  final PointModel geoLocationCoords;
  final String title;
  final String createdAt;

  Map<String, dynamic> toJson() => _$FavouriteModelToJson(this);
}

extension FavouriteModelExtenstion on FavouriteModel {
  Favourite toDomain() {
    return Favourite(
      id: id,
      createdAt: DateTime.parse(createdAt),
      geoLocationCoords: geoLocationCoords.toDomain(),
      title: title,
    );
  }
}
