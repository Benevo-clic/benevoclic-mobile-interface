import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/models/rule_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'isActif')
  final bool isActif;

  @JsonKey(name: 'isConnect')
  final bool isConnect;

  @JsonKey(name: 'rule')
  final RuleModel rule;

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