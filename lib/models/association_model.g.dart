// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'association_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Association _$AssociationFromJson(Map<String, dynamic> json) => Association(
      name: json['name'] as String,
      bio: json['bio'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      postalCode: json['postalCode'] as String,
      imageProfile: json['imageProfile'] as String,
      verified: json['verified'] as bool,
      siret: json['siret'] as String,
      announcement: (json['ads'] as List<dynamic>)
          .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
      volunteersWaiting: (json['volunteersWaiting'] as List<dynamic>)
          .map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      volunteers: (json['volunteers'] as List<dynamic>)
          .map((e) => ResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..id = json['id'] as String;

Map<String, dynamic> _$AssociationToJson(Association instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'city': instance.city,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'imageProfile': instance.imageProfile,
      'verified': instance.verified,
      'siret': instance.siret,
      'ads': instance.announcement,
      'volunteersWaiting': instance.volunteersWaiting,
      'volunteers': instance.volunteers,
    };
