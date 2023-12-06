

import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/response_model.dart';

import 'association_model.dart';

part 'volunteer_model.g.dart';

@JsonSerializable()
class Volunteer{

  @JsonKey(name: 'firstName')
  late final String firstName;

  @JsonKey(name: 'lastName')
  late final String lastName;

  @JsonKey(name: 'email')
  late final String email;

  @JsonKey(name: 'phone')
  late final String phone;

  @JsonKey(name: 'address')
  late final String address;

  @JsonKey(name: 'city')
  late final String city;

  @JsonKey(name: 'country')
  late final String country;

  @JsonKey(name: 'postalCode')
  late final String postalCode;

  @JsonKey(name: 'birthDayDate')
  late final String birthDayDate;

  @JsonKey(name: 'imageProfile')
  late final String imageProfile;

  @JsonKey(name: 'bio')
  late final String bio;

  @JsonKey(name: 'verified')
  late final bool verified;

  @JsonKey(name: 'myAssociations')
  late final List<ResponseModel> myAssociations;

  @JsonKey(name: 'myAssociationsWaiting')
  late final List<ResponseModel> myAssociationsWaiting;

  Volunteer(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.address,
      required this.city,
      required this.country,
      required this.postalCode,
      required this.birthDayDate,
      required this.imageProfile,
      required this.bio,
      required this.verified,
      required this.myAssociations,
      required this.myAssociationsWaiting});

  factory Volunteer.fromJson(Map<String, dynamic> json) => _$VolunteerFromJson(json);

  Map<String, dynamic> toJson() => _$VolunteerToJson(this);
}