// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagged_bin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaggedBin _$_$_TaggedBinFromJson(Map<String, dynamic> json) {
  return _$_TaggedBin(
    id: json['id'] as String,
    binName: json['binName'] as String,
    imageSrc: json['imageSrc'] as String,
    userId: json['userId'] as String,
    active: json['active'] as bool,
    isNew: json['isNew'] as bool,
    disposalsMade: json['disposalsMade'] as int,
    locationLan: (json['locationLan'] as num)?.toDouble(),
    locationLon: (json['locationLon'] as num)?.toDouble(),
    userName: json['userName'] as String,
    taggedTime: json['taggedTime'] == null
        ? null
        : DateTime.parse(json['taggedTime'] as String),
    pointsEarned: json['pointsEarned'] as int,
    reportStrikes: json['reportStrikes'] as int,
  );
}

Map<String, dynamic> _$_$_TaggedBinToJson(_$_TaggedBin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'binName': instance.binName,
      'imageSrc': instance.imageSrc,
      'userId': instance.userId,
      'active': instance.active,
      'isNew': instance.isNew,
      'disposalsMade': instance.disposalsMade,
      'locationLan': instance.locationLan,
      'locationLon': instance.locationLon,
      'userName': instance.userName,
      'taggedTime': instance.taggedTime?.toIso8601String(),
      'pointsEarned': instance.pointsEarned,
      'reportStrikes': instance.reportStrikes,
    };
