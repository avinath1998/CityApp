// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_winnings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ScanWinnings _$_$_ScanWinningsFromJson(Map<String, dynamic> json) {
  return _$_ScanWinnings(
    id: json['id'] as String,
    claimedByUserId: json['claimedByUserId'] as String,
    isActive: json['isActive'] as bool,
    winnings: (json['winnings'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_ScanWinningsToJson(_$_ScanWinnings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'claimedByUserId': instance.claimedByUserId,
      'isActive': instance.isActive,
      'winnings': instance.winnings,
    };
