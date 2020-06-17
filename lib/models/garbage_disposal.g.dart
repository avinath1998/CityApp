// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garbage_disposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GarbageDisposal _$_$_GarbageDisposalFromJson(Map<String, dynamic> json) {
  return _$_GarbageDisposal(
    id: json['id'] as String,
    type: json['type'] as String,
    count: json['count'] as int,
    weight: (json['weight'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_GarbageDisposalToJson(_$_GarbageDisposal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'count': instance.count,
      'weight': instance.weight,
    };
