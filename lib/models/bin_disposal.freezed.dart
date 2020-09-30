// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bin_disposal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BinDisposal _$BinDisposalFromJson(Map<String, dynamic> json) {
  return _BinDisposal.fromJson(json);
}

class _$BinDisposalTearOff {
  const _$BinDisposalTearOff();

// ignore: unused_element
  _BinDisposal call(
      {@required String binId,
      @required String userId,
      @required String binName,
      @required String wasteImageSrc,
      @required String binImageSrc,
      @required DateTime disposalTime,
      String message,
      int pointAmount,
      @required BinDisposalStatus status}) {
    return _BinDisposal(
      binId: binId,
      userId: userId,
      binName: binName,
      wasteImageSrc: wasteImageSrc,
      binImageSrc: binImageSrc,
      disposalTime: disposalTime,
      message: message,
      pointAmount: pointAmount,
      status: status,
    );
  }
}

// ignore: unused_element
const $BinDisposal = _$BinDisposalTearOff();

mixin _$BinDisposal {
  String get binId;
  String get userId;
  String get binName;
  String get wasteImageSrc;
  String get binImageSrc;
  DateTime get disposalTime;
  String get message;
  int get pointAmount;
  BinDisposalStatus get status;

  Map<String, dynamic> toJson();
  $BinDisposalCopyWith<BinDisposal> get copyWith;
}

abstract class $BinDisposalCopyWith<$Res> {
  factory $BinDisposalCopyWith(
          BinDisposal value, $Res Function(BinDisposal) then) =
      _$BinDisposalCopyWithImpl<$Res>;
  $Res call(
      {String binId,
      String userId,
      String binName,
      String wasteImageSrc,
      String binImageSrc,
      DateTime disposalTime,
      String message,
      int pointAmount,
      BinDisposalStatus status});
}

class _$BinDisposalCopyWithImpl<$Res> implements $BinDisposalCopyWith<$Res> {
  _$BinDisposalCopyWithImpl(this._value, this._then);

  final BinDisposal _value;
  // ignore: unused_field
  final $Res Function(BinDisposal) _then;

  @override
  $Res call({
    Object binId = freezed,
    Object userId = freezed,
    Object binName = freezed,
    Object wasteImageSrc = freezed,
    Object binImageSrc = freezed,
    Object disposalTime = freezed,
    Object message = freezed,
    Object pointAmount = freezed,
    Object status = freezed,
  }) {
    return _then(_value.copyWith(
      binId: binId == freezed ? _value.binId : binId as String,
      userId: userId == freezed ? _value.userId : userId as String,
      binName: binName == freezed ? _value.binName : binName as String,
      wasteImageSrc: wasteImageSrc == freezed
          ? _value.wasteImageSrc
          : wasteImageSrc as String,
      binImageSrc:
          binImageSrc == freezed ? _value.binImageSrc : binImageSrc as String,
      disposalTime: disposalTime == freezed
          ? _value.disposalTime
          : disposalTime as DateTime,
      message: message == freezed ? _value.message : message as String,
      pointAmount:
          pointAmount == freezed ? _value.pointAmount : pointAmount as int,
      status: status == freezed ? _value.status : status as BinDisposalStatus,
    ));
  }
}

abstract class _$BinDisposalCopyWith<$Res>
    implements $BinDisposalCopyWith<$Res> {
  factory _$BinDisposalCopyWith(
          _BinDisposal value, $Res Function(_BinDisposal) then) =
      __$BinDisposalCopyWithImpl<$Res>;
  @override
  $Res call(
      {String binId,
      String userId,
      String binName,
      String wasteImageSrc,
      String binImageSrc,
      DateTime disposalTime,
      String message,
      int pointAmount,
      BinDisposalStatus status});
}

class __$BinDisposalCopyWithImpl<$Res> extends _$BinDisposalCopyWithImpl<$Res>
    implements _$BinDisposalCopyWith<$Res> {
  __$BinDisposalCopyWithImpl(
      _BinDisposal _value, $Res Function(_BinDisposal) _then)
      : super(_value, (v) => _then(v as _BinDisposal));

  @override
  _BinDisposal get _value => super._value as _BinDisposal;

  @override
  $Res call({
    Object binId = freezed,
    Object userId = freezed,
    Object binName = freezed,
    Object wasteImageSrc = freezed,
    Object binImageSrc = freezed,
    Object disposalTime = freezed,
    Object message = freezed,
    Object pointAmount = freezed,
    Object status = freezed,
  }) {
    return _then(_BinDisposal(
      binId: binId == freezed ? _value.binId : binId as String,
      userId: userId == freezed ? _value.userId : userId as String,
      binName: binName == freezed ? _value.binName : binName as String,
      wasteImageSrc: wasteImageSrc == freezed
          ? _value.wasteImageSrc
          : wasteImageSrc as String,
      binImageSrc:
          binImageSrc == freezed ? _value.binImageSrc : binImageSrc as String,
      disposalTime: disposalTime == freezed
          ? _value.disposalTime
          : disposalTime as DateTime,
      message: message == freezed ? _value.message : message as String,
      pointAmount:
          pointAmount == freezed ? _value.pointAmount : pointAmount as int,
      status: status == freezed ? _value.status : status as BinDisposalStatus,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_BinDisposal with DiagnosticableTreeMixin implements _BinDisposal {
  _$_BinDisposal(
      {@required this.binId,
      @required this.userId,
      @required this.binName,
      @required this.wasteImageSrc,
      @required this.binImageSrc,
      @required this.disposalTime,
      this.message,
      this.pointAmount,
      @required this.status})
      : assert(binId != null),
        assert(userId != null),
        assert(binName != null),
        assert(wasteImageSrc != null),
        assert(binImageSrc != null),
        assert(disposalTime != null),
        assert(status != null);

  factory _$_BinDisposal.fromJson(Map<String, dynamic> json) =>
      _$_$_BinDisposalFromJson(json);

  @override
  final String binId;
  @override
  final String userId;
  @override
  final String binName;
  @override
  final String wasteImageSrc;
  @override
  final String binImageSrc;
  @override
  final DateTime disposalTime;
  @override
  final String message;
  @override
  final int pointAmount;
  @override
  final BinDisposalStatus status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BinDisposal(binId: $binId, userId: $userId, binName: $binName, wasteImageSrc: $wasteImageSrc, binImageSrc: $binImageSrc, disposalTime: $disposalTime, message: $message, pointAmount: $pointAmount, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BinDisposal'))
      ..add(DiagnosticsProperty('binId', binId))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('binName', binName))
      ..add(DiagnosticsProperty('wasteImageSrc', wasteImageSrc))
      ..add(DiagnosticsProperty('binImageSrc', binImageSrc))
      ..add(DiagnosticsProperty('disposalTime', disposalTime))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('pointAmount', pointAmount))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BinDisposal &&
            (identical(other.binId, binId) ||
                const DeepCollectionEquality().equals(other.binId, binId)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.binName, binName) ||
                const DeepCollectionEquality()
                    .equals(other.binName, binName)) &&
            (identical(other.wasteImageSrc, wasteImageSrc) ||
                const DeepCollectionEquality()
                    .equals(other.wasteImageSrc, wasteImageSrc)) &&
            (identical(other.binImageSrc, binImageSrc) ||
                const DeepCollectionEquality()
                    .equals(other.binImageSrc, binImageSrc)) &&
            (identical(other.disposalTime, disposalTime) ||
                const DeepCollectionEquality()
                    .equals(other.disposalTime, disposalTime)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.pointAmount, pointAmount) ||
                const DeepCollectionEquality()
                    .equals(other.pointAmount, pointAmount)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(binId) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(binName) ^
      const DeepCollectionEquality().hash(wasteImageSrc) ^
      const DeepCollectionEquality().hash(binImageSrc) ^
      const DeepCollectionEquality().hash(disposalTime) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(pointAmount) ^
      const DeepCollectionEquality().hash(status);

  @override
  _$BinDisposalCopyWith<_BinDisposal> get copyWith =>
      __$BinDisposalCopyWithImpl<_BinDisposal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BinDisposalToJson(this);
  }
}

abstract class _BinDisposal implements BinDisposal {
  factory _BinDisposal(
      {@required String binId,
      @required String userId,
      @required String binName,
      @required String wasteImageSrc,
      @required String binImageSrc,
      @required DateTime disposalTime,
      String message,
      int pointAmount,
      @required BinDisposalStatus status}) = _$_BinDisposal;

  factory _BinDisposal.fromJson(Map<String, dynamic> json) =
      _$_BinDisposal.fromJson;

  @override
  String get binId;
  @override
  String get userId;
  @override
  String get binName;
  @override
  String get wasteImageSrc;
  @override
  String get binImageSrc;
  @override
  DateTime get disposalTime;
  @override
  String get message;
  @override
  int get pointAmount;
  @override
  BinDisposalStatus get status;
  @override
  _$BinDisposalCopyWith<_BinDisposal> get copyWith;
}
