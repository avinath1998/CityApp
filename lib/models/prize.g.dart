// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prize.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Prize _$_$_PrizeFromJson(Map<String, dynamic> json) {
  return _$_Prize(
    desc: json['desc'] as String,
    image: json['image'] as String,
    remaining: json['remaining'] as int,
    expirationDate: json['expirationDate'] == null
        ? null
        : DateTime.parse(json['expirationDate'] as String),
    name: json['name'] as String,
    id: json['id'] as String,
    cost: json['cost'] as int,
    status:
        _$enumDecodeNullable(_$PrizeRedemptionStatusEnumMap, json['status']),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$_PrizeToJson(_$_Prize instance) => <String, dynamic>{
      'desc': instance.desc,
      'image': instance.image,
      'remaining': instance.remaining,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'name': instance.name,
      'id': instance.id,
      'cost': instance.cost,
      'status': _$PrizeRedemptionStatusEnumMap[instance.status],
      'type': instance.type,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PrizeRedemptionStatusEnumMap = {
  PrizeRedemptionStatus.delivered: 'delivered',
  PrizeRedemptionStatus.notEnoughPoints: 'notEnoughPoints',
  PrizeRedemptionStatus.couponCodesFinished: 'couponCodesFinished',
  PrizeRedemptionStatus.disallowed: 'disallowed',
  PrizeRedemptionStatus.waiting: 'waiting',
};
