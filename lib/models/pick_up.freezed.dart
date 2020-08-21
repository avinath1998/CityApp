// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'pick_up.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Pickup _$PickupFromJson(Map<String, dynamic> json) {
  return _Pickup.fromJson(json);
}

class _$PickupTearOff {
  const _$PickupTearOff();

// ignore: unused_element
  _Pickup call(
      {@required String id,
      @required String userId,
      @required String collectionTripId,
      @required String status,
      int pointsAwarded,
      @required List<GarbageDisposal> garbageDisposals}) {
    return _Pickup(
      id: id,
      userId: userId,
      collectionTripId: collectionTripId,
      status: status,
      pointsAwarded: pointsAwarded,
      garbageDisposals: garbageDisposals,
    );
  }
}

// ignore: unused_element
const $Pickup = _$PickupTearOff();

mixin _$Pickup {
  String get id;
  String get userId;
  String get collectionTripId;
  String get status;
  int get pointsAwarded;
  List<GarbageDisposal> get garbageDisposals;

  Map<String, dynamic> toJson();
  $PickupCopyWith<Pickup> get copyWith;
}

abstract class $PickupCopyWith<$Res> {
  factory $PickupCopyWith(Pickup value, $Res Function(Pickup) then) =
      _$PickupCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      String collectionTripId,
      String status,
      int pointsAwarded,
      List<GarbageDisposal> garbageDisposals});
}

class _$PickupCopyWithImpl<$Res> implements $PickupCopyWith<$Res> {
  _$PickupCopyWithImpl(this._value, this._then);

  final Pickup _value;
  // ignore: unused_field
  final $Res Function(Pickup) _then;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object collectionTripId = freezed,
    Object status = freezed,
    Object pointsAwarded = freezed,
    Object garbageDisposals = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      collectionTripId: collectionTripId == freezed
          ? _value.collectionTripId
          : collectionTripId as String,
      status: status == freezed ? _value.status : status as String,
      pointsAwarded: pointsAwarded == freezed
          ? _value.pointsAwarded
          : pointsAwarded as int,
      garbageDisposals: garbageDisposals == freezed
          ? _value.garbageDisposals
          : garbageDisposals as List<GarbageDisposal>,
    ));
  }
}

abstract class _$PickupCopyWith<$Res> implements $PickupCopyWith<$Res> {
  factory _$PickupCopyWith(_Pickup value, $Res Function(_Pickup) then) =
      __$PickupCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      String collectionTripId,
      String status,
      int pointsAwarded,
      List<GarbageDisposal> garbageDisposals});
}

class __$PickupCopyWithImpl<$Res> extends _$PickupCopyWithImpl<$Res>
    implements _$PickupCopyWith<$Res> {
  __$PickupCopyWithImpl(_Pickup _value, $Res Function(_Pickup) _then)
      : super(_value, (v) => _then(v as _Pickup));

  @override
  _Pickup get _value => super._value as _Pickup;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object collectionTripId = freezed,
    Object status = freezed,
    Object pointsAwarded = freezed,
    Object garbageDisposals = freezed,
  }) {
    return _then(_Pickup(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      collectionTripId: collectionTripId == freezed
          ? _value.collectionTripId
          : collectionTripId as String,
      status: status == freezed ? _value.status : status as String,
      pointsAwarded: pointsAwarded == freezed
          ? _value.pointsAwarded
          : pointsAwarded as int,
      garbageDisposals: garbageDisposals == freezed
          ? _value.garbageDisposals
          : garbageDisposals as List<GarbageDisposal>,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_Pickup implements _Pickup {
  _$_Pickup(
      {@required this.id,
      @required this.userId,
      @required this.collectionTripId,
      @required this.status,
      this.pointsAwarded,
      @required this.garbageDisposals})
      : assert(id != null),
        assert(userId != null),
        assert(collectionTripId != null),
        assert(status != null),
        assert(garbageDisposals != null);

  factory _$_Pickup.fromJson(Map<String, dynamic> json) =>
      _$_$_PickupFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String collectionTripId;
  @override
  final String status;
  @override
  final int pointsAwarded;
  @override
  final List<GarbageDisposal> garbageDisposals;

  @override
  String toString() {
    return 'Pickup(id: $id, userId: $userId, collectionTripId: $collectionTripId, status: $status, pointsAwarded: $pointsAwarded, garbageDisposals: $garbageDisposals)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Pickup &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.collectionTripId, collectionTripId) ||
                const DeepCollectionEquality()
                    .equals(other.collectionTripId, collectionTripId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.pointsAwarded, pointsAwarded) ||
                const DeepCollectionEquality()
                    .equals(other.pointsAwarded, pointsAwarded)) &&
            (identical(other.garbageDisposals, garbageDisposals) ||
                const DeepCollectionEquality()
                    .equals(other.garbageDisposals, garbageDisposals)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(collectionTripId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(pointsAwarded) ^
      const DeepCollectionEquality().hash(garbageDisposals);

  @override
  _$PickupCopyWith<_Pickup> get copyWith =>
      __$PickupCopyWithImpl<_Pickup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PickupToJson(this);
  }
}

abstract class _Pickup implements Pickup {
  factory _Pickup(
      {@required String id,
      @required String userId,
      @required String collectionTripId,
      @required String status,
      int pointsAwarded,
      @required List<GarbageDisposal> garbageDisposals}) = _$_Pickup;

  factory _Pickup.fromJson(Map<String, dynamic> json) = _$_Pickup.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get collectionTripId;
  @override
  String get status;
  @override
  int get pointsAwarded;
  @override
  List<GarbageDisposal> get garbageDisposals;
  @override
  _$PickupCopyWith<_Pickup> get copyWith;
}
