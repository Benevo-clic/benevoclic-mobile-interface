import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/response_model.dart';

part 'announcement_model.g.dart';

@JsonSerializable()
class Announcement {
  @JsonKey(name: 'associationId')
  late final String associationId;

  @JsonKey(name: 'dateEvent')
  late final String dateEvent;

  @JsonKey(name: 'datePublication')
  late final String datePublication;

  @JsonKey(name: 'description')
  late final String description;

  @JsonKey(name: 'full')
  late final bool full;

  @JsonKey(name: 'image')
  late final String image;

  @JsonKey(name: 'location')
  late final String location;

  @JsonKey(name: 'nameAssociation')
  late final String nameAssociation;

  @JsonKey(name: 'nameEvent')
  late final String nameEvent;

  @JsonKey(name: 'nbHours')
  late final int nbHours;

  @JsonKey(name: 'nbPlaces')
  late final int nbPlaces;

  @JsonKey(name: 'nbPlacesTaken')
  late final int nbPlacesTaken;

  @JsonKey(name: 'tags')
  late final List<String> tags;

  @JsonKey(name: 'type')
  late final String type;

  @JsonKey(name: 'volunteers')
  late final List<ResponseModel> volunteers;

  @JsonKey(name: 'volunteersWaiting')
  late final List<ResponseModel> volunteersWaiting;

  Announcement(
      {required this.associationId,
      required this.dateEvent,
      required this.datePublication,
      required this.description,
      required this.full,
      required this.image,
      required this.location,
      required this.nameAssociation,
      required this.nameEvent,
      required this.nbHours,
      required this.nbPlaces,
      required this.nbPlacesTaken,
      required this.tags,
      required this.type,
      required this.volunteers,
      required this.volunteersWaiting});

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);


}
