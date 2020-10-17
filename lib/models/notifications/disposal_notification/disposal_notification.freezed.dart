// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'disposal_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
DisposalNotification _$DisposalNotificationFromJson(Map<String, dynamic> json) {
  return _DisposalNotification.fromJson(json);
}

class _$DisposalNotificationTearOff {
  const _$DisposalNotificationTearOff();

// ignore: unused_element
  _DisposalNotification call(
      {String title,
      String body,
      String imageSrc,
      BinDisposalStatus status,
      NotificationType type}) {
    return _DisposalNotification(
      title: title,
      body: body,
      imageSrc: imageSrc,
      status: status,
      type: type,
    );
  }
}

// ignore: unused_element
const $DisposalNotification = _$DisposalNotificationTearOff();

mixin _$DisposalNotification {
  String get title;
  String get body;
  String get imageSrc;
  BinDisposalStatus get status;
  NotificationType get type;

  Map<String, dynamic> toJson();
  $DisposalNotificationCopyWith<DisposalNotification> get copyWith;
}

abstract class $DisposalNotificationCopyWith<$Res> {
  factory $DisposalNotificationCopyWith(DisposalNotification value,
          $Res Function(DisposalNotification) then) =
      _$DisposalNotificationCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String body,
      String imageSrc,
      BinDisposalStatus status,
      NotificationType type});
}

class _$DisposalNotificationCopyWithImpl<$Res>
    implements $DisposalNotificationCopyWith<$Res> {
  _$DisposalNotificationCopyWithImpl(this._value, this._then);

  final DisposalNotification _value;
  // ignore: unused_field
  final $Res Function(DisposalNotification) _then;

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
      status: status == freezed ? _value.status : status as BinDisposalStatus,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

abstract class _$DisposalNotificationCopyWith<$Res>
    implements $DisposalNotificationCopyWith<$Res> {
  factory _$DisposalNotificationCopyWith(_DisposalNotification value,
          $Res Function(_DisposalNotification) then) =
      __$DisposalNotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String body,
      String imageSrc,
      BinDisposalStatus status,
      NotificationType type});
}

class __$DisposalNotificationCopyWithImpl<$Res>
    extends _$DisposalNotificationCopyWithImpl<$Res>
    implements _$DisposalNotificationCopyWith<$Res> {
  __$DisposalNotificationCopyWithImpl(
      _DisposalNotification _value, $Res Function(_DisposalNotification) _then)
      : super(_value, (v) => _then(v as _DisposalNotification));

  @override
  _DisposalNotification get _value => super._value as _DisposalNotification;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object imageSrc = freezed,
    Object status = freezed,
    Object type = freezed,
  }) {
    return _then(_DisposalNotification(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      status: status == freezed ? _value.status : status as BinDisposalStatus,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

@JsonSerializable()
class _$_DisposalNotification implements _DisposalNotification {
  _$_DisposalNotification(
      {this.title, this.body, this.imageSrc, this.status, this.type});

  factory _$_DisposalNotification.fromJson(Map<String, dynamic> json) =>
      _$_$_DisposalNotificationFromJson(json);

  @override
  final String title;
  @override
  final String body;
  @override
  final String imageSrc;
  @override
  final BinDisposalStatus status;
  @override
  final NotificationType type;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DisposalNotification &&
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
  _$DisposalNotificationCopyWith<_DisposalNotification> get copyWith =>
      __$DisposalNotificationCopyWithImpl<_DisposalNotification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DisposalNotificationToJson(this);
  }
}

abstract class _DisposalNotification implements DisposalNotification {
  factory _DisposalNotification(
      {String title,
      String body,
      String imageSrc,
      BinDisposalStatus status,
      NotificationType type}) = _$_DisposalNotification;

  factory _DisposalNotification.fromJson(Map<String, dynamic> json) =
      _$_DisposalNotification.fromJson;

  @override
  String get title;
  @override
  String get body;
  @override
  String get imageSrc;
  @override
  BinDisposalStatus get status;
  @override
  NotificationType get type;
  @override
  _$DisposalNotificationCopyWith<_DisposalNotification> get copyWith;
}
