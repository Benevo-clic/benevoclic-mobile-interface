

import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/response_model.dart';

part 'volunteer_model.g.dart';

@JsonSerializable()
class Volunteer{
  @JsonKey(name: 'id')
  late final String? id;

  @JsonKey(name: 'firstName')
  late final String firstName;

  @JsonKey(name: 'lastName')
  late final String lastName;

  @JsonKey(name: 'email')
  late final String? email;

  @JsonKey(name: 'phone')
  late final String phone;

  @JsonKey(name: 'address')
  late final String? address;

  @JsonKey(name: 'city')
  late final String? city;

  @JsonKey(name: 'postalCode')
  late final String? postalCode;

  @JsonKey(name: 'birthDayDate')
  late final String birthDayDate;

  @JsonKey(name: 'imageProfile')
  String? imageProfile =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

  @JsonKey(name: 'bio')
  late final String? bio;

  @JsonKey(name: 'myAssociations')
  late final List<ResponseModel>? myAssociations;

  @JsonKey(name: 'myAssociationsWaiting')
  late final List<ResponseModel>? myAssociationsWaiting;

  Volunteer(
      {required this.firstName,
      this.id,
      required this.lastName,
      this.email,
      required this.phone,
      this.address,
      this.city,
      this.postalCode,
      required this.birthDayDate,
      this.imageProfile,
      this.bio,
      this.myAssociations,
      this.myAssociationsWaiting});

  factory Volunteer.fromJson(Map<String, dynamic> json) => _$VolunteerFromJson(json);

  Map<String, dynamic> toJson() => _$VolunteerToJson(this);
}