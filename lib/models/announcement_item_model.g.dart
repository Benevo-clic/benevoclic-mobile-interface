// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementItem _$AnnouncementItemFromJson(Map<String, dynamic> json) =>
    AnnouncementItem(
      id: json['_id'] as String?,
      labelEvent: json['nameEvent'] as String,
    );

Map<String, dynamic> _$AnnouncementItemToJson(AnnouncementItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nameEvent': instance.labelEvent,
    };
