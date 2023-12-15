// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Volunteer _$VolunteerFromJson(Map<String, dynamic> json) => Volunteer(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
      birthDayDate: json['birthDayDate'] as String,
      imageProfile: json['imageProfile'] as String,
      bio: json['bio'] as String,
      verified: json['verified'] as bool?,
      myAssociations: (json['myAssociations'] as List<dynamic>?)
          ?.map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      myAssociationsWaiting: (json['myAssociationsWaiting'] as List<dynamic>?)
          ?.map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VolunteerToJson(Volunteer instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'birthDayDate': instance.birthDayDate,
      'imageProfile': instance.imageProfile,
      'bio': instance.bio,
      'verified': instance.verified,
      'myAssociations': instance.myAssociations,
      'myAssociationsWaiting': instance.myAssociationsWaiting,
    };
