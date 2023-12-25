// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      id: json['id'] as String?,
      idAssociation: json['idAssociation'] as String,
      dateEvent: json['dateEvent'] as String,
      datePublication: json['datePublication'] as String,
      description: json['description'] as String,
      full: json['full'] as bool?,
      image: json['image'] as String? ?? 'https://via.placeholder.com/150',
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      nameAssociation: json['nameAssociation'] as String?,
      labelEvent: json['labelEvent'] as String,
      nbHours: json['nbHours'] as int,
      nbPlaces: json['nbPlaces'] as int,
      nbPlacesTaken: json['nbPlacesTaken'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: json['type'] as String,
      volunteers: (json['volunteers'] as List<dynamic>?)
          ?.map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageProfileAssociation: json['imageProfileAssociation'] as String,
      volunteersWaiting: (json['volunteersWaiting'] as List<dynamic>?)
          ?.map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idAssociation': instance.idAssociation,
      'dateEvent': instance.dateEvent,
      'datePublication': instance.datePublication,
      'description': instance.description,
      'full': instance.full,
      'image': instance.image,
      'location': instance.location,
      'nameAssociation': instance.nameAssociation,
      'imageProfileAssociation': instance.imageProfileAssociation,
      'labelEvent': instance.labelEvent,
      'nbHours': instance.nbHours,
      'nbPlaces': instance.nbPlaces,
      'nbPlacesTaken': instance.nbPlacesTaken,
      'tags': instance.tags,
      'type': instance.type,
      'volunteers': instance.volunteers,
      'volunteersWaiting': instance.volunteersWaiting,
    };
