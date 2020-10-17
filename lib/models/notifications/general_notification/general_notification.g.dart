// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GeneralNotification _$_$_GeneralNotificationFromJson(
    Map<String, dynamic> json) {
  return _$_GeneralNotification(
    title: json['title'] as String,
    body: json['body'] as String,
    type: _$enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$_$_GeneralNotificationToJson(
        _$_GeneralNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
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

const _$NotificationTypeEnumMap = {
  NotificationType.prize: 'prize',
  NotificationType.disposal: 'disposal',
  NotificationType.addBin: 'addBin',
  NotificationType.general: 'general',
};
