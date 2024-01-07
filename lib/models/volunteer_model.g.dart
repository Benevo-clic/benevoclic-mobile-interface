// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Volunteer _$VolunteerFromJson(Map<String, dynamic> json) => Volunteer(
      firstName: json['firstName'] as String,
      id: json['id'] as String?,
      lastName: json['lastName'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
      birthDayDate: json['birthDayDate'] as String,
      imageProfile: json['imageProfile'] as String?,
      bio: json['bio'] as String?,
      myAssociations: (json['myAssociations'] as List<dynamic>?)
          ?.map((e) => Association.fromJson(e as Map<String, dynamic>))
          .toList(),
      myAssociationsWaiting: (json['myAssociationsWaiting'] as List<dynamic>?)
          ?.map((e) => Association.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VolunteerToJson(Volunteer instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'location': instance.location,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'birthDayDate': instance.birthDayDate,
      'imageProfile': instance.imageProfile,
      'bio': instance.bio,
      'myAssociations': instance.myAssociations,
      'myAssociationsWaiting': instance.myAssociationsWaiting,
    };
