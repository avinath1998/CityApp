// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prize_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PrizeNotification _$_$_PrizeNotificationFromJson(Map<String, dynamic> json) {
  return _$_PrizeNotification(
    title: json['title'] as String,
    body: json['body'] as String,
    imageSrc: json['imageSrc'] as String,
    status:
        _$enumDecodeNullable(_$PrizeRedemptionStatusEnumMap, json['status']),
    type: _$enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$_$_PrizeNotificationToJson(
        _$_PrizeNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imageSrc': instance.imageSrc,
      'status': _$PrizeRedemptionStatusEnumMap[instance.status],
      'type': _$NotificationTypeEnumMap[instance.type],
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

const _$NotificationTypeEnumMap = {
  NotificationType.prize: 'prize',
  NotificationType.disposal: 'disposal',
  NotificationType.addBin: 'addBin',
  NotificationType.general: 'general',
};
