import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class Place {
  @JsonKey(name: 'description')
  late String description;

  @JsonKey(name: 'place_id')
  late String placeId;

  Place({
    required this.description,
    required this.placeId,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
