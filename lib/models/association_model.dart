import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/location_model.dart';
import 'package:namer_app/models/response_model.dart';
import 'package:namer_app/models/volunteer_model.dart';

import 'location_model.dart';

part 'association_model.g.dart';

@JsonSerializable()
class Association {
  @JsonKey(name: 'id')
  late final String? id;

  @JsonKey(name: 'name')
  late final String name;

  @JsonKey(name: 'bio')
  late final String? bio;

  @JsonKey(name: 'location')
  late final LocationModel? location;

  @JsonKey(name: 'phone')
  late final String phone;

  @JsonKey(name: 'email')
  late final String? email;

  @JsonKey(name: 'city')
  late final String? city;


  @JsonKey(name: 'postalCode')
  late final String? postalCode;

  @JsonKey(name: 'imageProfile')
  String? imageProfile =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

  @JsonKey(name: 'verified')
  late final bool? verified;


  @JsonKey(name: 'announcement')
  late final List<Announcement>? announcement;

  @JsonKey(name: 'type')
  late final String type;

  @JsonKey(name: 'volunteersWaiting')
  final List<Volunteer>? volunteersWaiting;

  @JsonKey(name: 'volunteers')
  final List<Volunteer>? volunteers;

  Association(
      {this.id,
      required this.name,
      this.bio,
      this.location,
      required this.phone,
      this.email,
      this.city,
      this.postalCode,
      this.imageProfile,
      this.verified,
      this.announcement,
      required this.type,
      this.volunteersWaiting,
      this.volunteers});

  factory Association.fromJson(Map<String, dynamic> json) =>
      _$AssociationFromJson(json);

  Map<String, dynamic> toJson() => _$AssociationToJson(this);
}
