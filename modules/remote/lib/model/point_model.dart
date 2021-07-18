import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/point.dart';

part 'point_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class PointModel {
  const PointModel({
    required this.type,
    required this.coordinates,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);

  final String type;
  final List<double> coordinates;

  Map<String, dynamic> toJson() => _$PointModelToJson(this);
}

extension PointModelExtenstion on PointModel {
  Point toDomain() {
    return Point(
      type: type,
      coordinates: coordinates,
    );
  }
}
