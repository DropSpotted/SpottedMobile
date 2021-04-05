import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/post_creation.dart';

part 'create_post_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class CreatePostModel {
  const CreatePostModel({required this.body, required this.geoLocationCoords});

  factory CreatePostModel.fromJson(Map<String, dynamic> json) => _$CreatePostModelFromJson(json);

  final String body;
  final String geoLocationCoords;

  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);
}

extension CreatePostModelExtension on CreatePostModel {
  PostCreation toDomain() {
    return PostCreation(
      body: body,
      lat: 0.0,
      lon: 0.0,
    );
  }
}

extension CreatePostExtension on PostCreation {
  CreatePostModel toRemote() {
    return CreatePostModel(
      body: body,
      geoLocationCoords: 'POINT($lat $lon)',
    );
  }
}
