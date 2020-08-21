// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'live_bin_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
LiveBinSetting _$LiveBinSettingFromJson(Map<String, dynamic> json) {
  return _LiveBinSetting.fromJson(json);
}

class _$LiveBinSettingTearOff {
  const _$LiveBinSettingTearOff();

// ignore: unused_element
  _LiveBinSetting call(
      {@required String id,
      @required String locationName,
      @required int endTime,
      @required int startTime}) {
    return _LiveBinSetting(
      id: id,
      locationName: locationName,
      endTime: endTime,
      startTime: startTime,
    );
  }
}

// ignore: unused_element
const $LiveBinSetting = _$LiveBinSettingTearOff();

mixin _$LiveBinSetting {
  String get id;
  String get locationName;
  int get endTime;
  int get startTime;

  Map<String, dynamic> toJson();
  $LiveBinSettingCopyWith<LiveBinSetting> get copyWith;
}

abstract class $LiveBinSettingCopyWith<$Res> {
  factory $LiveBinSettingCopyWith(
          LiveBinSetting value, $Res Function(LiveBinSetting) then) =
      _$LiveBinSettingCopyWithImpl<$Res>;
  $Res call({String id, String locationName, int endTime, int startTime});
}

class _$LiveBinSettingCopyWithImpl<$Res>
    implements $LiveBinSettingCopyWith<$Res> {
  _$LiveBinSettingCopyWithImpl(this._value, this._then);

  final LiveBinSetting _value;
  // ignore: unused_field
  final $Res Function(LiveBinSetting) _then;

  @override
  $Res call({
    Object id = freezed,
    Object locationName = freezed,
    Object endTime = freezed,
    Object startTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      locationName: locationName == freezed
          ? _value.locationName
          : locationName as String,
      endTime: endTime == freezed ? _value.endTime : endTime as int,
      startTime: startTime == freezed ? _value.startTime : startTime as int,
    ));
  }
}

abstract class _$LiveBinSettingCopyWith<$Res>
    implements $LiveBinSettingCopyWith<$Res> {
  factory _$LiveBinSettingCopyWith(
          _LiveBinSetting value, $Res Function(_LiveBinSetting) then) =
      __$LiveBinSettingCopyWithImpl<$Res>;
  @override
  $Res call({String id, String locationName, int endTime, int startTime});
}

class __$LiveBinSettingCopyWithImpl<$Res>
    extends _$LiveBinSettingCopyWithImpl<$Res>
    implements _$LiveBinSettingCopyWith<$Res> {
  __$LiveBinSettingCopyWithImpl(
      _LiveBinSetting _value, $Res Function(_LiveBinSetting) _then)
      : super(_value, (v) => _then(v as _LiveBinSetting));

  @override
  _LiveBinSetting get _value => super._value as _LiveBinSetting;

  @override
  $Res call({
    Object id = freezed,
    Object locationName = freezed,
    Object endTime = freezed,
    Object startTime = freezed,
  }) {
    return _then(_LiveBinSetting(
      id: id == freezed ? _value.id : id as String,
      locationName: locationName == freezed
          ? _value.locationName
          : locationName as String,
      endTime: endTime == freezed ? _value.endTime : endTime as int,
      startTime: startTime == freezed ? _value.startTime : startTime as int,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_LiveBinSetting implements _LiveBinSetting {
  _$_LiveBinSetting(
      {@required this.id,
      @required this.locationName,
      @required this.endTime,
      @required this.startTime})
      : assert(id != null),
        assert(locationName != null),
        assert(endTime != null),
        assert(startTime != null);

  factory _$_LiveBinSetting.fromJson(Map<String, dynamic> json) =>
      _$_$_LiveBinSettingFromJson(json);

  @override
  final String id;
  @override
  final String locationName;
  @override
  final int endTime;
  @override
  final int startTime;

  @override
  String toString() {
    return 'LiveBinSetting(id: $id, locationName: $locationName, endTime: $endTime, startTime: $startTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LiveBinSetting &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.locationName, locationName) ||
                const DeepCollectionEquality()
                    .equals(other.locationName, locationName)) &&
            (identical(other.endTime, endTime) ||
                const DeepCollectionEquality()
                    .equals(other.endTime, endTime)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(locationName) ^
      const DeepCollectionEquality().hash(endTime) ^
      const DeepCollectionEquality().hash(startTime);

  @override
  _$LiveBinSettingCopyWith<_LiveBinSetting> get copyWith =>
      __$LiveBinSettingCopyWithImpl<_LiveBinSetting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LiveBinSettingToJson(this);
  }
}

abstract class _LiveBinSetting implements LiveBinSetting {
  factory _LiveBinSetting(
      {@required String id,
      @required String locationName,
      @required int endTime,
      @required int startTime}) = _$_LiveBinSetting;

  factory _LiveBinSetting.fromJson(Map<String, dynamic> json) =
      _$_LiveBinSetting.fromJson;

  @override
  String get id;
  @override
  String get locationName;
  @override
  int get endTime;
  @override
  int get startTime;
  @override
  _$LiveBinSettingCopyWith<_LiveBinSetting> get copyWith;
}
