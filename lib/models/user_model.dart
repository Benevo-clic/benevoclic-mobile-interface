import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/rule_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'isActif')
  late final bool isActif;

  @JsonKey(name: 'isConnect')
  late final bool isConnect;

  @JsonKey(name: 'rule')
  final RuleModel rule;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'isVerified')
  final bool isVerified;

  UserModel(this.isVerified, {
    required this.id,
    required this.isActif,
    required this.isConnect,
    required this.rule,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}