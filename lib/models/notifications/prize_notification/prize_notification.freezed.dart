// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'prize_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
PrizeNotification _$PrizeNotificationFromJson(Map<String, dynamic> json) {
  return _PrizeNotification.fromJson(json);
}

class _$PrizeNotificationTearOff {
  const _$PrizeNotificationTearOff();

// ignore: unused_element
  _PrizeNotification call(
      {String title,
      String body,
      String imageSrc,
      PrizeRedemptionStatus status,
      NotificationType type}) {
    return _PrizeNotification(
      title: title,
      body: body,
      imageSrc: imageSrc,
      status: status,
      type: type,
    );
  }
}

// ignore: unused_element
const $PrizeNotification = _$PrizeNotificationTearOff();

mixin _$PrizeNotification {
  String get title;
  String get body;
  String get imageSrc;
  PrizeRedemptionStatus get status;
  NotificationType get type;

  Map<String, dynamic> toJson();
  $PrizeNotificationCopyWith<PrizeNotification> get copyWith;
}

abstract class $PrizeNotificationCopyWith<$Res> {
  factory $PrizeNotificationCopyWith(
          PrizeNotification value, $Res Function(PrizeNotification) then) =
      _$PrizeNotificationCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String body,
      String imageSrc,
      PrizeRedemptionStatus status,
      NotificationType type});
}

class _$PrizeNotificationCopyWithImpl<$Res>
    implements $PrizeNotificationCopyWith<$Res> {
  _$PrizeNotificationCopyWithImpl(this._value, this._then);

  final PrizeNotification _value;
  // ignore: unused_field
  final $Res Function(PrizeNotification) _then;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object imageSrc = freezed,
    Object status = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      status:
          status == freezed ? _value.status : status as PrizeRedemptionStatus,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

abstract class _$PrizeNotificationCopyWith<$Res>
    implements $PrizeNotificationCopyWith<$Res> {
  factory _$PrizeNotificationCopyWith(
          _PrizeNotification value, $Res Function(_PrizeNotification) then) =
      __$PrizeNotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String body,
      String imageSrc,
      PrizeRedemptionStatus status,
      NotificationType type});
}

class __$PrizeNotificationCopyWithImpl<$Res>
    extends _$PrizeNotificationCopyWithImpl<$Res>
    implements _$PrizeNotificationCopyWith<$Res> {
  __$PrizeNotificationCopyWithImpl(
      _PrizeNotification _value, $Res Function(_PrizeNotification) _then)
      : super(_value, (v) => _then(v as _PrizeNotification));

  @override
  _PrizeNotification get _value => super._value as _PrizeNotification;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object imageSrc = freezed,
    Object status = freezed,
    Object type = freezed,
  }) {
    return _then(_PrizeNotification(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      status:
          status == freezed ? _value.status : status as PrizeRedemptionStatus,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

@JsonSerializable()
class _$_PrizeNotification implements _PrizeNotification {
  _$_PrizeNotification(
      {this.title, this.body, this.imageSrc, this.status, this.type});

  factory _$_PrizeNotification.fromJson(Map<String, dynamic> json) =>
      _$_$_PrizeNotificationFromJson(json);

  @override
  final String title;
  @override
  final String body;
  @override
  final String imageSrc;
  @override
  final PrizeRedemptionStatus status;
  @override
  final NotificationType type;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PrizeNotification &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.imageSrc, imageSrc) ||
                const DeepCollectionEquality()
                    .equals(other.imageSrc, imageSrc)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(imageSrc) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type);

  @override
  _$PrizeNotificationCopyWith<_PrizeNotification> get copyWith =>
      __$PrizeNotificationCopyWithImpl<_PrizeNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PrizeNotificationToJson(this);
  }
}

abstract class _PrizeNotification implements PrizeNotification {
  factory _PrizeNotification(
      {String title,
      String body,
      String imageSrc,
      PrizeRedemptionStatus status,
      NotificationType type}) = _$_PrizeNotification;

  factory _PrizeNotification.fromJson(Map<String, dynamic> json) =
      _$_PrizeNotification.fromJson;

  @override
  String get title;
  @override
  String get body;
  @override
  String get imageSrc;
  @override
  PrizeRedemptionStatus get status;
  @override
  NotificationType get type;
  @override
  _$PrizeNotificationCopyWith<_PrizeNotification> get copyWith;
}
