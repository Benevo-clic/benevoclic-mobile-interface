import 'package:json_annotation/json_annotation.dart';

part 'rule_model.g.dart';

@JsonSerializable()
class RuleModel {
  @JsonKey(name: 'rulesType')
  String rulesType;

  RuleModel({
    required this.rulesType,
  });

  factory RuleModel.fromJson(Map<String, dynamic> json) =>
      _$RuleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RuleModelToJson(this);
}
