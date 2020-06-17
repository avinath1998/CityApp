// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cityscan_qrcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CityScanQrCode _$_$_CityScanQrCodeFromJson(Map<String, dynamic> json) {
  return _$_CityScanQrCode(
    type: json['type'] as String,
    id: json['id'] as String,
    wasteType: json['wasteType'] as String,
    locLong: (json['locLong'] as num)?.toDouble(),
    locLan: (json['locLan'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_CityScanQrCodeToJson(_$_CityScanQrCode instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'wasteType': instance.wasteType,
      'locLong': instance.locLong,
      'locLan': instance.locLan,
    };
