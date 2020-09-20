// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redemption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Redemption _$_$_RedemptionFromJson(Map<String, dynamic> json) {
  return _$_Redemption(
    id: json['id'] as String,
    userId: json['userId'] as String,
    prizeId: json['prizeId'] as String,
    title: json['title'] as String,
    desc: json['desc'] as String,
    cost: json['cost'] as int,
    redeemTime: json['redeemTime'] == null
        ? null
        : DateTime.parse(json['redeemTime'] as String),
    image: json['image'] as String,
    status:
        _$enumDecodeNullable(_$PrizeRedemptionStatusEnumMap, json['status']),
    code: json['code'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$_$_RedemptionToJson(_$_Redemption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'prizeId': instance.prizeId,
      'title': instance.title,
      'desc': instance.desc,
      'cost': instance.cost,
      'redeemTime': instance.redeemTime?.toIso8601String(),
      'image': instance.image,
      'status': _$PrizeRedemptionStatusEnumMap[instance.status],
      'code': instance.code,
      'message': instance.message,
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
