// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorites _$FavoritesFromJson(Map<String, dynamic> json) => Favorites(
      idVolunteer: json['idVolunteer'] as String,
      announcementFavorites: (json['announcementFavorites'] as List<dynamic>)
          .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoritesToJson(Favorites instance) => <String, dynamic>{
      'idVolunteer': instance.idVolunteer,
      'announcementFavorites': instance.announcementFavorites,
    };
