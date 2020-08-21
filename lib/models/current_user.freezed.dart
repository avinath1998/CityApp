// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'current_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return _CurrentUser.fromJson(json);
}

class _$CurrentUserTearOff {
  const _$CurrentUserTearOff();

// ignore: unused_element
  _CurrentUser call(
      {String address,
      DateTime dob,
      int points,
      List<Pickup> pickups,
      List<Redemption> redemptions,
      String id,
      String name,
      UserType userType}) {
    return _CurrentUser(
      address: address,
      dob: dob,
      points: points,
      pickups: pickups,
      redemptions: redemptions,
      id: id,
      name: name,
      userType: userType,
    );
  }
}

// ignore: unused_element
const $CurrentUser = _$CurrentUserTearOff();

mixin _$CurrentUser {
  String get address;
  DateTime get dob;
  int get points;
  List<Pickup> get pickups;
  List<Redemption> get redemptions;
  String get id;
  String get name;
  UserType get userType;

  Map<String, dynamic> toJson();
  $CurrentUserCopyWith<CurrentUser> get copyWith;
}

abstract class $CurrentUserCopyWith<$Res> {
  factory $CurrentUserCopyWith(
          CurrentUser value, $Res Function(CurrentUser) then) =
      _$CurrentUserCopyWithImpl<$Res>;
  $Res call(
      {String address,
      DateTime dob,
      int points,
      List<Pickup> pickups,
      List<Redemption> redemptions,
      String id,
      String name,
      UserType userType});
}

class _$CurrentUserCopyWithImpl<$Res> implements $CurrentUserCopyWith<$Res> {
  _$CurrentUserCopyWithImpl(this._value, this._then);

  final CurrentUser _value;
  // ignore: unused_field
  final $Res Function(CurrentUser) _then;

  @override
  $Res call({
    Object address = freezed,
    Object dob = freezed,
    Object points = freezed,
    Object pickups = freezed,
    Object redemptions = freezed,
    Object id = freezed,
    Object name = freezed,
    Object userType = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed ? _value.address : address as String,
      dob: dob == freezed ? _value.dob : dob as DateTime,
      points: points == freezed ? _value.points : points as int,
      pickups: pickups == freezed ? _value.pickups : pickups as List<Pickup>,
      redemptions: redemptions == freezed
          ? _value.redemptions
          : redemptions as List<Redemption>,
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      userType: userType == freezed ? _value.userType : userType as UserType,
    ));
  }
}

abstract class _$CurrentUserCopyWith<$Res>
    implements $CurrentUserCopyWith<$Res> {
  factory _$CurrentUserCopyWith(
          _CurrentUser value, $Res Function(_CurrentUser) then) =
      __$CurrentUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String address,
      DateTime dob,
      int points,
      List<Pickup> pickups,
      List<Redemption> redemptions,
      String id,
      String name,
      UserType userType});
}

class __$CurrentUserCopyWithImpl<$Res> extends _$CurrentUserCopyWithImpl<$Res>
    implements _$CurrentUserCopyWith<$Res> {
  __$CurrentUserCopyWithImpl(
      _CurrentUser _value, $Res Function(_CurrentUser) _then)
      : super(_value, (v) => _then(v as _CurrentUser));

  @override
  _CurrentUser get _value => super._value as _CurrentUser;

  @override
  $Res call({
    Object address = freezed,
    Object dob = freezed,
    Object points = freezed,
    Object pickups = freezed,
    Object redemptions = freezed,
    Object id = freezed,
    Object name = freezed,
    Object userType = freezed,
  }) {
    return _then(_CurrentUser(
      address: address == freezed ? _value.address : address as String,
      dob: dob == freezed ? _value.dob : dob as DateTime,
      points: points == freezed ? _value.points : points as int,
      pickups: pickups == freezed ? _value.pickups : pickups as List<Pickup>,
      redemptions: redemptions == freezed
          ? _value.redemptions
          : redemptions as List<Redemption>,
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      userType: userType == freezed ? _value.userType : userType as UserType,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_CurrentUser with DiagnosticableTreeMixin implements _CurrentUser {
  _$_CurrentUser(
      {this.address,
      this.dob,
      this.points,
      this.pickups,
      this.redemptions,
      this.id,
      this.name,
      this.userType});

  factory _$_CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$_$_CurrentUserFromJson(json);

  @override
  final String address;
  @override
  final DateTime dob;
  @override
  final int points;
  @override
  final List<Pickup> pickups;
  @override
  final List<Redemption> redemptions;
  @override
  final String id;
  @override
  final String name;
  @override
  final UserType userType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CurrentUser(address: $address, dob: $dob, points: $points, pickups: $pickups, redemptions: $redemptions, id: $id, name: $name, userType: $userType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CurrentUser'))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('dob', dob))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('pickups', pickups))
      ..add(DiagnosticsProperty('redemptions', redemptions))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('userType', userType));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CurrentUser &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.dob, dob) ||
                const DeepCollectionEquality().equals(other.dob, dob)) &&
            (identical(other.points, points) ||
                const DeepCollectionEquality().equals(other.points, points)) &&
            (identical(other.pickups, pickups) ||
                const DeepCollectionEquality()
                    .equals(other.pickups, pickups)) &&
            (identical(other.redemptions, redemptions) ||
                const DeepCollectionEquality()
                    .equals(other.redemptions, redemptions)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.userType, userType) ||
                const DeepCollectionEquality()
                    .equals(other.userType, userType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(dob) ^
      const DeepCollectionEquality().hash(points) ^
      const DeepCollectionEquality().hash(pickups) ^
      const DeepCollectionEquality().hash(redemptions) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(userType);

  @override
  _$CurrentUserCopyWith<_CurrentUser> get copyWith =>
      __$CurrentUserCopyWithImpl<_CurrentUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CurrentUserToJson(this);
  }
}

abstract class _CurrentUser implements CurrentUser {
  factory _CurrentUser(
      {String address,
      DateTime dob,
      int points,
      List<Pickup> pickups,
      List<Redemption> redemptions,
      String id,
      String name,
      UserType userType}) = _$_CurrentUser;

  factory _CurrentUser.fromJson(Map<String, dynamic> json) =
      _$_CurrentUser.fromJson;

  @override
  String get address;
  @override
  DateTime get dob;
  @override
  int get points;
  @override
  List<Pickup> get pickups;
  @override
  List<Redemption> get redemptions;
  @override
  String get id;
  @override
  String get name;
  @override
  UserType get userType;
  @override
  _$CurrentUserCopyWith<_CurrentUser> get copyWith;
}
