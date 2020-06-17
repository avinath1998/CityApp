// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'redemption.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Redemption _$RedemptionFromJson(Map<String, dynamic> json) {
  return _Redemption.fromJson(json);
}

class _$RedemptionTearOff {
  const _$RedemptionTearOff();

  _Redemption call(
      {String id,
      String userId,
      String prizeId,
      String title,
      String desc,
      int cost,
      String redeemTime,
      RedemptionStatus status,
      int indexNumber,
      String declinedReason}) {
    return _Redemption(
      id: id,
      userId: userId,
      prizeId: prizeId,
      title: title,
      desc: desc,
      cost: cost,
      redeemTime: redeemTime,
      status: status,
      indexNumber: indexNumber,
      declinedReason: declinedReason,
    );
  }
}

// ignore: unused_element
const $Redemption = _$RedemptionTearOff();

mixin _$Redemption {
  String get id;
  String get userId;
  String get prizeId;
  String get title;
  String get desc;
  int get cost;
  String get redeemTime;
  RedemptionStatus get status;
  int get indexNumber;
  String get declinedReason;

  Map<String, dynamic> toJson();
  $RedemptionCopyWith<Redemption> get copyWith;
}

abstract class $RedemptionCopyWith<$Res> {
  factory $RedemptionCopyWith(
          Redemption value, $Res Function(Redemption) then) =
      _$RedemptionCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      String prizeId,
      String title,
      String desc,
      int cost,
      String redeemTime,
      RedemptionStatus status,
      int indexNumber,
      String declinedReason});
}

class _$RedemptionCopyWithImpl<$Res> implements $RedemptionCopyWith<$Res> {
  _$RedemptionCopyWithImpl(this._value, this._then);

  final Redemption _value;
  // ignore: unused_field
  final $Res Function(Redemption) _then;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object prizeId = freezed,
    Object title = freezed,
    Object desc = freezed,
    Object cost = freezed,
    Object redeemTime = freezed,
    Object status = freezed,
    Object indexNumber = freezed,
    Object declinedReason = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      prizeId: prizeId == freezed ? _value.prizeId : prizeId as String,
      title: title == freezed ? _value.title : title as String,
      desc: desc == freezed ? _value.desc : desc as String,
      cost: cost == freezed ? _value.cost : cost as int,
      redeemTime:
          redeemTime == freezed ? _value.redeemTime : redeemTime as String,
      status: status == freezed ? _value.status : status as RedemptionStatus,
      indexNumber:
          indexNumber == freezed ? _value.indexNumber : indexNumber as int,
      declinedReason: declinedReason == freezed
          ? _value.declinedReason
          : declinedReason as String,
    ));
  }
}

abstract class _$RedemptionCopyWith<$Res> implements $RedemptionCopyWith<$Res> {
  factory _$RedemptionCopyWith(
          _Redemption value, $Res Function(_Redemption) then) =
      __$RedemptionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      String prizeId,
      String title,
      String desc,
      int cost,
      String redeemTime,
      RedemptionStatus status,
      int indexNumber,
      String declinedReason});
}

class __$RedemptionCopyWithImpl<$Res> extends _$RedemptionCopyWithImpl<$Res>
    implements _$RedemptionCopyWith<$Res> {
  __$RedemptionCopyWithImpl(
      _Redemption _value, $Res Function(_Redemption) _then)
      : super(_value, (v) => _then(v as _Redemption));

  @override
  _Redemption get _value => super._value as _Redemption;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object prizeId = freezed,
    Object title = freezed,
    Object desc = freezed,
    Object cost = freezed,
    Object redeemTime = freezed,
    Object status = freezed,
    Object indexNumber = freezed,
    Object declinedReason = freezed,
  }) {
    return _then(_Redemption(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      prizeId: prizeId == freezed ? _value.prizeId : prizeId as String,
      title: title == freezed ? _value.title : title as String,
      desc: desc == freezed ? _value.desc : desc as String,
      cost: cost == freezed ? _value.cost : cost as int,
      redeemTime:
          redeemTime == freezed ? _value.redeemTime : redeemTime as String,
      status: status == freezed ? _value.status : status as RedemptionStatus,
      indexNumber:
          indexNumber == freezed ? _value.indexNumber : indexNumber as int,
      declinedReason: declinedReason == freezed
          ? _value.declinedReason
          : declinedReason as String,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_Redemption implements _Redemption {
  _$_Redemption(
      {this.id,
      this.userId,
      this.prizeId,
      this.title,
      this.desc,
      this.cost,
      this.redeemTime,
      this.status,
      this.indexNumber,
      this.declinedReason});

  factory _$_Redemption.fromJson(Map<String, dynamic> json) =>
      _$_$_RedemptionFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String prizeId;
  @override
  final String title;
  @override
  final String desc;
  @override
  final int cost;
  @override
  final String redeemTime;
  @override
  final RedemptionStatus status;
  @override
  final int indexNumber;
  @override
  final String declinedReason;

  @override
  String toString() {
    return 'Redemption(id: $id, userId: $userId, prizeId: $prizeId, title: $title, desc: $desc, cost: $cost, redeemTime: $redeemTime, status: $status, indexNumber: $indexNumber, declinedReason: $declinedReason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Redemption &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.prizeId, prizeId) ||
                const DeepCollectionEquality()
                    .equals(other.prizeId, prizeId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.desc, desc) ||
                const DeepCollectionEquality().equals(other.desc, desc)) &&
            (identical(other.cost, cost) ||
                const DeepCollectionEquality().equals(other.cost, cost)) &&
            (identical(other.redeemTime, redeemTime) ||
                const DeepCollectionEquality()
                    .equals(other.redeemTime, redeemTime)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.indexNumber, indexNumber) ||
                const DeepCollectionEquality()
                    .equals(other.indexNumber, indexNumber)) &&
            (identical(other.declinedReason, declinedReason) ||
                const DeepCollectionEquality()
                    .equals(other.declinedReason, declinedReason)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(prizeId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(desc) ^
      const DeepCollectionEquality().hash(cost) ^
      const DeepCollectionEquality().hash(redeemTime) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(indexNumber) ^
      const DeepCollectionEquality().hash(declinedReason);

  @override
  _$RedemptionCopyWith<_Redemption> get copyWith =>
      __$RedemptionCopyWithImpl<_Redemption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RedemptionToJson(this);
  }
}

abstract class _Redemption implements Redemption {
  factory _Redemption(
      {String id,
      String userId,
      String prizeId,
      String title,
      String desc,
      int cost,
      String redeemTime,
      RedemptionStatus status,
      int indexNumber,
      String declinedReason}) = _$_Redemption;

  factory _Redemption.fromJson(Map<String, dynamic> json) =
      _$_Redemption.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get prizeId;
  @override
  String get title;
  @override
  String get desc;
  @override
  int get cost;
  @override
  String get redeemTime;
  @override
  RedemptionStatus get status;
  @override
  int get indexNumber;
  @override
  String get declinedReason;
  @override
  _$RedemptionCopyWith<_Redemption> get copyWith;
}