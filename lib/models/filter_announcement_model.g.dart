// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterAnnouncement _$FilterAnnouncementFromJson(Map<String, dynamic> json) =>
    FilterAnnouncement(
      sortBy: json['sortBy'] as String?,
      hours: json['hours'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      timeOfDay: json['timeOfDay'] as List<dynamic>?,
      userLatitude: (json['userLatitude'] as num?)?.toDouble(),
      userLongitude: (json['userLongitude'] as num?)?.toDouble(),
      maxDistance: (json['maxDistance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FilterAnnouncementToJson(FilterAnnouncement instance) =>
    <String, dynamic>{
      'sortBy': instance.sortBy,
      'hours': instance.hours,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'timeOfDay': instance.timeOfDay,
      'userLatitude': instance.userLatitude,
      'userLongitude': instance.userLongitude,
      'maxDistance': instance.maxDistance,
    };
