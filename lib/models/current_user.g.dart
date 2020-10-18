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
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    fcmToken: json['fcmToken'] as String,
    phoneNumber: json['phoneNumber'] as String,
    password: json['password'] as String,
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
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'fcmToken': instance.fcmToken,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
    };
