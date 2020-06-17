// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pickup _$_$_PickupFromJson(Map<String, dynamic> json) {
  return _$_Pickup(
    id: json['id'] as String,
    userId: json['userId'] as String,
    collectionTripId: json['collectionTripId'] as String,
    status: json['status'] as String,
    pointsAwarded: json['pointsAwarded'] as int,
    garbageDisposals: (json['garbageDisposals'] as List)
        ?.map((e) => e == null
            ? null
            : GarbageDisposal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_PickupToJson(_$_Pickup instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'collectionTripId': instance.collectionTripId,
      'status': instance.status,
      'pointsAwarded': instance.pointsAwarded,
      'garbageDisposals':
          instance.garbageDisposals?.map((e) => e?.toJson())?.toList(),
    };
