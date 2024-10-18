// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocketResponseModel _$SocketResponseModelFromJson(Map<String, dynamic> json) =>
    SocketResponseModel(
      roomSeq: (json['roomSeq'] as num).toInt(),
      memberLocationResList: (json['memberLocationResList'] as List<dynamic>)
          .map((e) => SocketMemberListModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SocketResponseModelToJson(
        SocketResponseModel instance) =>
    <String, dynamic>{
      'roomSeq': instance.roomSeq,
      'memberLocationResList': instance.memberLocationResList,
    };

SocketMemberListModel _$SocketMemberListModelFromJson(
        Map<String, dynamic> json) =>
    SocketMemberListModel(
      memberSeq: (json['memberSeq'] as num).toInt(),
      nickname: json['nickname'] as String,
      imageUrl: json['imageUrl'] as String,
      presentLat: (json['presentLat'] as num).toDouble(),
      presentLng: (json['presentLng'] as num).toDouble(),
      destinationDistance: (json['destinationDistance'] as num).toDouble(),
      rank: (json['rank'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SocketMemberListModelToJson(
        SocketMemberListModel instance) =>
    <String, dynamic>{
      'memberSeq': instance.memberSeq,
      'nickname': instance.nickname,
      'imageUrl': instance.imageUrl,
      'presentLat': instance.presentLat,
      'presentLng': instance.presentLng,
      'destinationDistance': instance.destinationDistance,
      'rank': instance.rank,
    };
