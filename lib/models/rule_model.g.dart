// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleModel _$RuleModelFromJson(Map<String, dynamic> json) => RuleModel(
      rulesType: $enumDecode(_$RulesTypeEnumMap, json['rulesType']),
    );

Map<String, dynamic> _$RuleModelToJson(RuleModel instance) => <String, dynamic>{
      'rulesType': _$RulesTypeEnumMap[instance.rulesType]!,
    };

const _$RulesTypeEnumMap = {
  RulesType.USER_ASSOCIATION: 'USER_ASSOCIATION',
  RulesType.USER_VOLUNTEER: 'USER_VOLUNTEER',
  RulesType.NONE: 'NONE',
};
