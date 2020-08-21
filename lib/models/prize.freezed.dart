// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'prize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Prize _$PrizeFromJson(Map<String, dynamic> json) {
  return _Prize.fromJson(json);
}

class _$PrizeTearOff {
  const _$PrizeTearOff();

// ignore: unused_element
  _Prize call(
      {String desc,
      String image,
      int remaining,
      DateTime expirationDate,
      String name,
      String id,
      int cost,
      PrizeRedemptionStatus status,
      String type}) {
    return _Prize(
      desc: desc,
      image: image,
      remaining: remaining,
      expirationDate: expirationDate,
      name: name,
      id: id,
      cost: cost,
      status: status,
      type: type,
    );
  }
}

// ignore: unused_element
const $Prize = _$PrizeTearOff();

mixin _$Prize {
  String get desc;
  String get image;
  int get remaining;
  DateTime get expirationDate;
  String get name;
  String get id;
  int get cost;
  PrizeRedemptionStatus get status;
  String get type;

  Map<String, dynamic> toJson();
  $PrizeCopyWith<Prize> get copyWith;
}

abstract class $PrizeCopyWith<$Res> {
  factory $PrizeCopyWith(Prize value, $Res Function(Prize) then) =
      _$PrizeCopyWithImpl<$Res>;
  $Res call(
      {String desc,
      String image,
      int remaining,
      DateTime expirationDate,
      String name,
      String id,
      int cost,
      PrizeRedemptionStatus status,
      String type});
}

class _$PrizeCopyWithImpl<$Res> implements $PrizeCopyWith<$Res> {
  _$PrizeCopyWithImpl(this._value, this._then);

  final Prize _value;
  // ignore: unused_field
  final $Res Function(Prize) _then;

  @override
  $Res call({
    Object desc = freezed,
    Object image = freezed,
    Object remaining = freezed,
    Object expirationDate = freezed,
    Object name = freezed,
    Object id = freezed,
    Object cost = freezed,
    Object status = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      desc: desc == freezed ? _value.desc : desc as String,
      image: image == freezed ? _value.image : image as String,
      remaining: remaining == freezed ? _value.remaining : remaining as int,
      expirationDate: expirationDate == freezed
          ? _value.expirationDate
          : expirationDate as DateTime,
      name: name == freezed ? _value.name : name as String,
      id: id == freezed ? _value.id : id as String,
      cost: cost == freezed ? _value.cost : cost as int,
      status:
          status == freezed ? _value.status : status as PrizeRedemptionStatus,
      type: type == freezed ? _value.type : type as String,
    ));
  }
}

abstract class _$PrizeCopyWith<$Res> implements $PrizeCopyWith<$Res> {
  factory _$PrizeCopyWith(_Prize value, $Res Function(_Prize) then) =
      __$PrizeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String desc,
      String image,
      int remaining,
      DateTime expirationDate,
      String name,
      String id,
      int cost,
      PrizeRedemptionStatus status,
      String type});
}

class __$PrizeCopyWithImpl<$Res> extends _$PrizeCopyWithImpl<$Res>
    implements _$PrizeCopyWith<$Res> {
  __$PrizeCopyWithImpl(_Prize _value, $Res Function(_Prize) _then)
      : super(_value, (v) => _then(v as _Prize));

  @override
  _Prize get _value => super._value as _Prize;

  @override
  $Res call({
    Object desc = freezed,
    Object image = freezed,
    Object remaining = freezed,
    Object expirationDate = freezed,
    Object name = freezed,
    Object id = freezed,
    Object cost = freezed,
    Object status = freezed,
    Object type = freezed,
  }) {
    return _then(_Prize(
      desc: desc == freezed ? _value.desc : desc as String,
      image: image == freezed ? _value.image : image as String,
      remaining: remaining == freezed ? _value.remaining : remaining as int,
      expirationDate: expirationDate == freezed
          ? _value.expirationDate
          : expirationDate as DateTime,
      name: name == freezed ? _value.name : name as String,
      id: id == freezed ? _value.id : id as String,
      cost: cost == freezed ? _value.cost : cost as int,
      status:
          status == freezed ? _value.status : status as PrizeRedemptionStatus,
      type: type == freezed ? _value.type : type as String,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_Prize implements _Prize {
  _$_Prize(
      {this.desc,
      this.image,
      this.remaining,
      this.expirationDate,
      this.name,
      this.id,
      this.cost,
      this.status,
      this.type});

  factory _$_Prize.fromJson(Map<String, dynamic> json) =>
      _$_$_PrizeFromJson(json);

  @override
  final String desc;
  @override
  final String image;
  @override
  final int remaining;
  @override
  final DateTime expirationDate;
  @override
  final String name;
  @override
  final String id;
  @override
  final int cost;
  @override
  final PrizeRedemptionStatus status;
  @override
  final String type;

  @override
  String toString() {
    return 'Prize(desc: $desc, image: $image, remaining: $remaining, expirationDate: $expirationDate, name: $name, id: $id, cost: $cost, status: $status, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Prize &&
            (identical(other.desc, desc) ||
                const DeepCollectionEquality().equals(other.desc, desc)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.remaining, remaining) ||
                const DeepCollectionEquality()
                    .equals(other.remaining, remaining)) &&
            (identical(other.expirationDate, expirationDate) ||
                const DeepCollectionEquality()
                    .equals(other.expirationDate, expirationDate)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.cost, cost) ||
                const DeepCollectionEquality().equals(other.cost, cost)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(desc) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(remaining) ^
      const DeepCollectionEquality().hash(expirationDate) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(cost) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type);

  @override
  _$PrizeCopyWith<_Prize> get copyWith =>
      __$PrizeCopyWithImpl<_Prize>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PrizeToJson(this);
  }
}

abstract class _Prize implements Prize {
  factory _Prize(
      {String desc,
      String image,
      int remaining,
      DateTime expirationDate,
      String name,
      String id,
      int cost,
      PrizeRedemptionStatus status,
      String type}) = _$_Prize;

  factory _Prize.fromJson(Map<String, dynamic> json) = _$_Prize.fromJson;

  @override
  String get desc;
  @override
  String get image;
  @override
  int get remaining;
  @override
  DateTime get expirationDate;
  @override
  String get name;
  @override
  String get id;
  @override
  int get cost;
  @override
  PrizeRedemptionStatus get status;
  @override
  String get type;
  @override
  _$PrizeCopyWith<_Prize> get copyWith;
}
