import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';

part 'announcement_item_model.g.dart';

@JsonSerializable()
class AnnouncementItem {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'dateEvent')
  late final String dateEvent;

  @JsonKey(name: 'datePublication')
  late final String datePublication;

  @JsonKey(name: 'description')
  late final String description;

  @JsonKey(name: 'location')
  late final LocationModel location;

  @JsonKey(name: 'nameAssociation')
  late final String nameAssociation;

  @JsonKey(name: 'imageProfileAssociation')
  final String imageProfileAssociation;

  @JsonKey(name: 'labelEvent')
  late final String labelEvent;

  @JsonKey(name: 'nbHours')
  late final int nbHours;

  @JsonKey(name: 'nbPlaces')
  late final int nbPlaces;

  @JsonKey(name: 'nbPlacesTaken')
  final int? nbPlacesTaken;

  final bool? isFavorite;

  AnnouncementItem({
    this.id,
    required this.dateEvent,
    required this.datePublication,
    required this.description,
    required this.location,
    required this.nameAssociation,
    required this.imageProfileAssociation,
    required this.labelEvent,
    required this.nbHours,
    required this.nbPlaces,
    this.nbPlacesTaken,
    this.isFavorite,
  });

  factory AnnouncementItem.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementItemToJson(this);
}
