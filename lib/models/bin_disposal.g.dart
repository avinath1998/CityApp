// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_disposal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BinDisposal _$_$_BinDisposalFromJson(Map<String, dynamic> json) {
  return _$_BinDisposal(
    binId: json['binId'] as String,
    userId: json['userId'] as String,
    binName: json['binName'] as String,
    wasteImageSrc: json['wasteImageSrc'] as String,
    binImageSrc: json['binImageSrc'] as String,
    disposalTime: json['disposalTime'] == null
        ? null
        : DateTime.parse(json['disposalTime'] as String),
    message: json['message'] as String,
    pointAmount: json['pointAmount'] as int,
    status: _$enumDecodeNullable(_$BinDisposalStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$_$_BinDisposalToJson(_$_BinDisposal instance) =>
    <String, dynamic>{
      'binId': instance.binId,
      'userId': instance.userId,
      'binName': instance.binName,
      'wasteImageSrc': instance.wasteImageSrc,
      'binImageSrc': instance.binImageSrc,
      'disposalTime': instance.disposalTime?.toIso8601String(),
      'message': instance.message,
      'pointAmount': instance.pointAmount,
      'status': _$BinDisposalStatusEnumMap[instance.status],
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

const _$BinDisposalStatusEnumMap = {
  BinDisposalStatus.pending: 'pending',
  BinDisposalStatus.approved: 'approved',
  BinDisposalStatus.disapproved: 'disapproved',
};
