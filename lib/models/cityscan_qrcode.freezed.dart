// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'cityscan_qrcode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CityScanQrCode _$CityScanQrCodeFromJson(Map<String, dynamic> json) {
  return _CityScanQrCode.fromJson(json);
}

class _$CityScanQrCodeTearOff {
  const _$CityScanQrCodeTearOff();

  _CityScanQrCode call(
      {@required String type,
      @required String id,
      @required String wasteType,
      @required double locLong,
      @required double locLan}) {
    return _CityScanQrCode(
      type: type,
      id: id,
      wasteType: wasteType,
      locLong: locLong,
      locLan: locLan,
    );
  }
}

// ignore: unused_element
const $CityScanQrCode = _$CityScanQrCodeTearOff();

mixin _$CityScanQrCode {
  String get type;
  String get id;
  String get wasteType;
  double get locLong;
  double get locLan;

  Map<String, dynamic> toJson();
  $CityScanQrCodeCopyWith<CityScanQrCode> get copyWith;
}

abstract class $CityScanQrCodeCopyWith<$Res> {
  factory $CityScanQrCodeCopyWith(
          CityScanQrCode value, $Res Function(CityScanQrCode) then) =
      _$CityScanQrCodeCopyWithImpl<$Res>;
  $Res call(
      {String type,
      String id,
      String wasteType,
      double locLong,
      double locLan});
}

class _$CityScanQrCodeCopyWithImpl<$Res>
    implements $CityScanQrCodeCopyWith<$Res> {
  _$CityScanQrCodeCopyWithImpl(this._value, this._then);

  final CityScanQrCode _value;
  // ignore: unused_field
  final $Res Function(CityScanQrCode) _then;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object wasteType = freezed,
    Object locLong = freezed,
    Object locLan = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as String,
      wasteType: wasteType == freezed ? _value.wasteType : wasteType as String,
      locLong: locLong == freezed ? _value.locLong : locLong as double,
      locLan: locLan == freezed ? _value.locLan : locLan as double,
    ));
  }
}

abstract class _$CityScanQrCodeCopyWith<$Res>
    implements $CityScanQrCodeCopyWith<$Res> {
  factory _$CityScanQrCodeCopyWith(
          _CityScanQrCode value, $Res Function(_CityScanQrCode) then) =
      __$CityScanQrCodeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String type,
      String id,
      String wasteType,
      double locLong,
      double locLan});
}

class __$CityScanQrCodeCopyWithImpl<$Res>
    extends _$CityScanQrCodeCopyWithImpl<$Res>
    implements _$CityScanQrCodeCopyWith<$Res> {
  __$CityScanQrCodeCopyWithImpl(
      _CityScanQrCode _value, $Res Function(_CityScanQrCode) _then)
      : super(_value, (v) => _then(v as _CityScanQrCode));

  @override
  _CityScanQrCode get _value => super._value as _CityScanQrCode;

  @override
  $Res call({
    Object type = freezed,
    Object id = freezed,
    Object wasteType = freezed,
    Object locLong = freezed,
    Object locLan = freezed,
  }) {
    return _then(_CityScanQrCode(
      type: type == freezed ? _value.type : type as String,
      id: id == freezed ? _value.id : id as String,
      wasteType: wasteType == freezed ? _value.wasteType : wasteType as String,
      locLong: locLong == freezed ? _value.locLong : locLong as double,
      locLan: locLan == freezed ? _value.locLan : locLan as double,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_CityScanQrCode
    with DiagnosticableTreeMixin
    implements _CityScanQrCode {
  _$_CityScanQrCode(
      {@required this.type,
      @required this.id,
      @required this.wasteType,
      @required this.locLong,
      @required this.locLan})
      : assert(type != null),
        assert(id != null),
        assert(wasteType != null),
        assert(locLong != null),
        assert(locLan != null);

  factory _$_CityScanQrCode.fromJson(Map<String, dynamic> json) =>
      _$_$_CityScanQrCodeFromJson(json);

  @override
  final String type;
  @override
  final String id;
  @override
  final String wasteType;
  @override
  final double locLong;
  @override
  final double locLan;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CityScanQrCode(type: $type, id: $id, wasteType: $wasteType, locLong: $locLong, locLan: $locLan)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CityScanQrCode'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('wasteType', wasteType))
      ..add(DiagnosticsProperty('locLong', locLong))
      ..add(DiagnosticsProperty('locLan', locLan));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CityScanQrCode &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.wasteType, wasteType) ||
                const DeepCollectionEquality()
                    .equals(other.wasteType, wasteType)) &&
            (identical(other.locLong, locLong) ||
                const DeepCollectionEquality()
                    .equals(other.locLong, locLong)) &&
            (identical(other.locLan, locLan) ||
                const DeepCollectionEquality().equals(other.locLan, locLan)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(wasteType) ^
      const DeepCollectionEquality().hash(locLong) ^
      const DeepCollectionEquality().hash(locLan);

  @override
  _$CityScanQrCodeCopyWith<_CityScanQrCode> get copyWith =>
      __$CityScanQrCodeCopyWithImpl<_CityScanQrCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CityScanQrCodeToJson(this);
  }
}

abstract class _CityScanQrCode implements CityScanQrCode {
  factory _CityScanQrCode(
      {@required String type,
      @required String id,
      @required String wasteType,
      @required double locLong,
      @required double locLan}) = _$_CityScanQrCode;

  factory _CityScanQrCode.fromJson(Map<String, dynamic> json) =
      _$_CityScanQrCode.fromJson;

  @override
  String get type;
  @override
  String get id;
  @override
  String get wasteType;
  @override
  double get locLong;
  @override
  double get locLan;
  @override
  _$CityScanQrCodeCopyWith<_CityScanQrCode> get copyWith;
}
