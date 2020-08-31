// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentUser _$_$_CurrentUserFromJson(Map<String, dynamic> json) {
  return _$_CurrentUser(
    address: json['address'] as String,
    dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
    points: json['points'] as int,
    pickups: (json['pickups'] as List)
        ?.map((e) =>
            e == null ? null : Pickup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    redemptions: (json['redemptions'] as List)
        ?.map((e) =>
            e == null ? null : Redemption.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    password: json['password'] as String,
    userType: _$enumDecodeNullable(_$UserTypeEnumMap, json['userType']),
  );
}

Map<String, dynamic> _$_$_CurrentUserToJson(_$_CurrentUser instance) =>
    <String, dynamic>{
      'address': instance.address,
      'dob': instance.dob?.toIso8601String(),
      'points': instance.points,
      'pickups': instance.pickups?.map((e) => e?.toJson())?.toList(),
      'redemptions': instance.redemptions?.map((e) => e?.toJson())?.toList(),
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'userType': _$UserTypeEnumMap[instance.userType],
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

const _$UserTypeEnumMap = {
  UserType.CurrentUser: 'CurrentUser',
  UserType.NormalUser: 'NormalUser',
};
