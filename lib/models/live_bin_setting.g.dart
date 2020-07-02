// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_bin_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LiveBinSetting _$_$_LiveBinSettingFromJson(Map<String, dynamic> json) {
  return _$_LiveBinSetting(
    id: json['id'] as String,
    locationName: json['locationName'] as String,
    endTime: json['endTime'] as int,
    startTime: json['startTime'] as int,
  );
}

Map<String, dynamic> _$_$_LiveBinSettingToJson(_$_LiveBinSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locationName': instance.locationName,
      'endTime': instance.endTime,
      'startTime': instance.startTime,
    };
