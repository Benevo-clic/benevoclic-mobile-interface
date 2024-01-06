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

  @JsonKey(name: 'hourEvent')
  late final String hourEvent;

  @JsonKey(name: 'datePublication')
  late final String datePublication;

  @JsonKey(name: 'description')
  late final String description;

  @JsonKey(name: 'isFull')
  final bool? full;

  @JsonKey(name: 'image', defaultValue: 'https://via.placeholder.com/150')
  String? image;

  @JsonKey(name: 'location')
  late final LocationModel location;

  @JsonKey(name: 'isVisible')
  final bool? isVisible;

  @JsonKey(name: 'nameAssociation')
  late final String nameAssociation;

  @JsonKey(name: 'imageProfileAssociation')
  String? imageProfileAssociation;

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

  bool? isFavorite;

  Announcement(
      {this.id,
      this.isFavorite,
      required this.idAssociation,
      required this.dateEvent,
      required this.datePublication,
      required this.description,
      this.full,
      this.isVisible,
      this.image,
      required this.hourEvent,
      required this.location,
      required this.nameAssociation,
      required this.labelEvent,
      required this.nbHours,
      required this.nbPlaces,
      this.nbPlacesTaken,
      this.tags,
      required this.type,
      this.volunteers,
      this.imageProfileAssociation,
      this.volunteersWaiting});

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  Announcement copyWith({
    String? id,
    String? idAssociation,
    String? dateEvent,
    String? hourEvent,
    String? datePublication,
    String? description,
    bool? full,
    String? image,
    LocationModel? location,
    bool? isVisible,
    String? nameAssociation,
    String? labelEvent,
    int? nbHours,
    int? nbPlaces,
    int? nbPlacesTaken,
    List<String>? tags,
    String? type,
    List<ResponseModel>? volunteers,
    List<ResponseModel>? volunteersWaiting,
    bool? isFavorite,
    String? imageProfileAssociation,
  }) {
    return Announcement(
      id: id ?? this.id,
      idAssociation: idAssociation ?? this.idAssociation,
      dateEvent: dateEvent ?? this.dateEvent,
      hourEvent: hourEvent ?? this.hourEvent,
      datePublication: datePublication ?? this.datePublication,
      description: description ?? this.description,
      full: full ?? this.full,
      image: image ?? this.image,
      location: location ?? this.location,
      isVisible: isVisible ?? this.isVisible,
      nameAssociation: nameAssociation ?? this.nameAssociation,
      labelEvent: labelEvent ?? this.labelEvent,
      nbHours: nbHours ?? this.nbHours,
      nbPlaces: nbPlaces ?? this.nbPlaces,
      nbPlacesTaken: nbPlacesTaken ?? this.nbPlacesTaken,
      tags: tags ?? this.tags,
      type: type ?? this.type,
      volunteers: volunteers ?? this.volunteers,
      volunteersWaiting: volunteersWaiting ?? this.volunteersWaiting,
      isFavorite: isFavorite ?? this.isFavorite,
      imageProfileAssociation:
          imageProfileAssociation ?? this.imageProfileAssociation,
    );
  }
}
