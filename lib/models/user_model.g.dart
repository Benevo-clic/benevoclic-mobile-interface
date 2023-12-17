// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      isActif: json['isActif'] as bool,
      isConnect: json['isConnect'] as bool,
      rule: RuleModel.fromJson(json['rule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'isActif': instance.isActif,
      'isConnect': instance.isConnect,
      'rule': instance.rule,
    };
