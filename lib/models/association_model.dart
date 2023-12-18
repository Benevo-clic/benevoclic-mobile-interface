import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/announcement_model.dart';
import 'package:namer_app/models/response_model.dart';

part 'association_model.g.dart';

@JsonSerializable()
class Association {
  @JsonKey(name: 'id')
  late final String? id;

  @JsonKey(name: 'name')
  late final String name;

  @JsonKey(name: 'bio')
  late final String? bio;

  @JsonKey(name: 'address')
  late final String? address;

  @JsonKey(name: 'phone')
  late final String phone;

  @JsonKey(name: 'email')
  late final String? email;

  @JsonKey(name: 'city')
  late final String? city;

  @JsonKey(name: 'country')
  late final String? country;

  @JsonKey(name: 'postalCode')
  late final String? postalCode;

  @JsonKey(name: 'imageProfile')
  late final String imageProfile;

  @JsonKey(name: 'verified')
  late final bool? verified;

  @JsonKey(name: 'siret')
  late final String? siret;

  @JsonKey(name: 'announcement')
  late final List<Announcement>? announcement;

  @JsonKey(name: 'type')
  late final String type;

  @JsonKey(name: 'volunteersWaiting')
  late final List<ResponseModel>? volunteersWaiting;

  @JsonKey(name: 'volunteers')
  late final List<ResponseModel>? volunteers;

  Association(
      {this.id,
      required this.name,
      this.bio,
      this.address,
      required this.phone,
      this.email,
      this.city,
      this.country,
      this.postalCode,
      required this.imageProfile,
      this.verified,
      this.siret,
      this.announcement,
      required this.type,
      this.volunteersWaiting,
      this.volunteers});

  factory Association.fromJson(Map<String, dynamic> json) =>
      _$AssociationFromJson(json);

  Map<String, dynamic> toJson() => _$AssociationToJson(this);
}
