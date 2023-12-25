import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/response_model.dart';

import 'location_model.dart';

part 'announcement_model.g.dart';

@JsonSerializable()
class Announcement {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'idAssociation')
  final String idAssociation;

  @JsonKey(name: 'dateEvent')
  late final String dateEvent;

  @JsonKey(name: 'datePublication')
  late final String datePublication;

  @JsonKey(name: 'description')
  late final String description;

  @JsonKey(name: 'full')
  final bool? full;

  @JsonKey(name: 'image', defaultValue: 'https://via.placeholder.com/150')
  String? image;

  @JsonKey(name: 'location')
  late final LocationModel location;

  @JsonKey(name: 'nameAssociation')
  final String? nameAssociation;

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

  @JsonKey(name: 'tags')
  final List<String>? tags;

  @JsonKey(name: 'type')
  late final String type;

  @JsonKey(name: 'volunteers')
  final List<ResponseModel>? volunteers;

  @JsonKey(name: 'volunteersWaiting')
  final List<ResponseModel>? volunteersWaiting;

  Announcement(
      {this.id,
      required this.idAssociation,
      required this.dateEvent,
      required this.datePublication,
      required this.description,
      this.full,
      this.image,
      required this.location,
      this.nameAssociation,
      required this.labelEvent,
      required this.nbHours,
      required this.nbPlaces,
      this.nbPlacesTaken,
      this.tags,
      required this.type,
      this.volunteers,
      required this.imageProfileAssociation,
      this.volunteersWaiting});

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
