// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'scan_winnings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ScanWinnings _$ScanWinningsFromJson(Map<String, dynamic> json) {
  return _ScanWinnings.fromJson(json);
}

class _$ScanWinningsTearOff {
  const _$ScanWinningsTearOff();

// ignore: unused_element
  _ScanWinnings call(
      {String id, String claimedByUserId, bool isActive, double winnings}) {
    return _ScanWinnings(
      id: id,
      claimedByUserId: claimedByUserId,
      isActive: isActive,
      winnings: winnings,
    );
  }
}

// ignore: unused_element
const $ScanWinnings = _$ScanWinningsTearOff();

mixin _$ScanWinnings {
  String get id;
  String get claimedByUserId;
  bool get isActive;
  double get winnings;

  Map<String, dynamic> toJson();
  $ScanWinningsCopyWith<ScanWinnings> get copyWith;
}

abstract class $ScanWinningsCopyWith<$Res> {
  factory $ScanWinningsCopyWith(
          ScanWinnings value, $Res Function(ScanWinnings) then) =
      _$ScanWinningsCopyWithImpl<$Res>;
  $Res call(
      {String id, String claimedByUserId, bool isActive, double winnings});
}

class _$ScanWinningsCopyWithImpl<$Res> implements $ScanWinningsCopyWith<$Res> {
  _$ScanWinningsCopyWithImpl(this._value, this._then);

  final ScanWinnings _value;
  // ignore: unused_field
  final $Res Function(ScanWinnings) _then;

  @override
  $Res call({
    Object id = freezed,
    Object claimedByUserId = freezed,
    Object isActive = freezed,
    Object winnings = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      claimedByUserId: claimedByUserId == freezed
          ? _value.claimedByUserId
          : claimedByUserId as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
      winnings: winnings == freezed ? _value.winnings : winnings as double,
    ));
  }
}

abstract class _$ScanWinningsCopyWith<$Res>
    implements $ScanWinningsCopyWith<$Res> {
  factory _$ScanWinningsCopyWith(
          _ScanWinnings value, $Res Function(_ScanWinnings) then) =
      __$ScanWinningsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String claimedByUserId, bool isActive, double winnings});
}

class __$ScanWinningsCopyWithImpl<$Res> extends _$ScanWinningsCopyWithImpl<$Res>
    implements _$ScanWinningsCopyWith<$Res> {
  __$ScanWinningsCopyWithImpl(
      _ScanWinnings _value, $Res Function(_ScanWinnings) _then)
      : super(_value, (v) => _then(v as _ScanWinnings));

  @override
  _ScanWinnings get _value => super._value as _ScanWinnings;

  @override
  $Res call({
    Object id = freezed,
    Object claimedByUserId = freezed,
    Object isActive = freezed,
    Object winnings = freezed,
  }) {
    return _then(_ScanWinnings(
      id: id == freezed ? _value.id : id as String,
      claimedByUserId: claimedByUserId == freezed
          ? _value.claimedByUserId
          : claimedByUserId as String,
      isActive: isActive == freezed ? _value.isActive : isActive as bool,
      winnings: winnings == freezed ? _value.winnings : winnings as double,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_ScanWinnings implements _ScanWinnings {
  _$_ScanWinnings(
      {this.id, this.claimedByUserId, this.isActive, this.winnings});

  factory _$_ScanWinnings.fromJson(Map<String, dynamic> json) =>
      _$_$_ScanWinningsFromJson(json);

  @override
  final String id;
  @override
  final String claimedByUserId;
  @override
  final bool isActive;
  @override
  final double winnings;

  @override
  String toString() {
    return 'ScanWinnings(id: $id, claimedByUserId: $claimedByUserId, isActive: $isActive, winnings: $winnings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ScanWinnings &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.claimedByUserId, claimedByUserId) ||
                const DeepCollectionEquality()
                    .equals(other.claimedByUserId, claimedByUserId)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.winnings, winnings) ||
                const DeepCollectionEquality()
                    .equals(other.winnings, winnings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(claimedByUserId) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(winnings);

  @override
  _$ScanWinningsCopyWith<_ScanWinnings> get copyWith =>
      __$ScanWinningsCopyWithImpl<_ScanWinnings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ScanWinningsToJson(this);
  }
}

abstract class _ScanWinnings implements ScanWinnings {
  factory _ScanWinnings(
      {String id,
      String claimedByUserId,
      bool isActive,
      double winnings}) = _$_ScanWinnings;

  factory _ScanWinnings.fromJson(Map<String, dynamic> json) =
      _$_ScanWinnings.fromJson;

  @override
  String get id;
  @override
  String get claimedByUserId;
  @override
  bool get isActive;
  @override
  double get winnings;
  @override
  _$ScanWinningsCopyWith<_ScanWinnings> get copyWith;
}
