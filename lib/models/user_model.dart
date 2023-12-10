import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'isActif')
  final String isActif;

  @JsonKey(name: 'isConnect')
  final String isConnect;

  @JsonKey(name: 'rule')
  final String rule;

  UserModel({
    required this.id,
    required this.isActif,
    required this.isConnect,
    required this.rule,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}