// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoModel _$MemberInfoModelFromJson(Map<String, dynamic> json) =>
    MemberInfoModel(
      nickname: json['nickname'] as String,
      identity: json['identity'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$MemberInfoModelToJson(MemberInfoModel instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'identity': instance.identity,
      'profileImageUrl': instance.profileImageUrl,
    };
