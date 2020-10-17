// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'add_bin_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AddBinNotification _$AddBinNotificationFromJson(Map<String, dynamic> json) {
  return _AddBinNotification.fromJson(json);
}

class _$AddBinNotificationTearOff {
  const _$AddBinNotificationTearOff();

// ignore: unused_element
  _AddBinNotification call(
      {String title,
      String body,
      String imageSrc,
      String isBinLive,
      NotificationType type}) {
    return _AddBinNotification(
      title: title,
      body: body,
      imageSrc: imageSrc,
      isBinLive: isBinLive,
      type: type,
    );
  }
}

// ignore: unused_element
const $AddBinNotification = _$AddBinNotificationTearOff();

mixin _$AddBinNotification {
  String get title;
  String get body;
  String get imageSrc;
  String get isBinLive;
  NotificationType get type;

  Map<String, dynamic> toJson();
  $AddBinNotificationCopyWith<AddBinNotification> get copyWith;
}

abstract class $AddBinNotificationCopyWith<$Res> {
  factory $AddBinNotificationCopyWith(
          AddBinNotification value, $Res Function(AddBinNotification) then) =
      _$AddBinNotificationCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String body,
      String imageSrc,
      String isBinLive,
      NotificationType type});
}

class _$AddBinNotificationCopyWithImpl<$Res>
    implements $AddBinNotificationCopyWith<$Res> {
  _$AddBinNotificationCopyWithImpl(this._value, this._then);

  final AddBinNotification _value;
  // ignore: unused_field
  final $Res Function(AddBinNotification) _then;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object imageSrc = freezed,
    Object isBinLive = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      isBinLive: isBinLive == freezed ? _value.isBinLive : isBinLive as String,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

abstract class _$AddBinNotificationCopyWith<$Res>
    implements $AddBinNotificationCopyWith<$Res> {
  factory _$AddBinNotificationCopyWith(
          _AddBinNotification value, $Res Function(_AddBinNotification) then) =
      __$AddBinNotificationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String body,
      String imageSrc,
      String isBinLive,
      NotificationType type});
}

class __$AddBinNotificationCopyWithImpl<$Res>
    extends _$AddBinNotificationCopyWithImpl<$Res>
    implements _$AddBinNotificationCopyWith<$Res> {
  __$AddBinNotificationCopyWithImpl(
      _AddBinNotification _value, $Res Function(_AddBinNotification) _then)
      : super(_value, (v) => _then(v as _AddBinNotification));

  @override
  _AddBinNotification get _value => super._value as _AddBinNotification;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object imageSrc = freezed,
    Object isBinLive = freezed,
    Object type = freezed,
  }) {
    return _then(_AddBinNotification(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      isBinLive: isBinLive == freezed ? _value.isBinLive : isBinLive as String,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

@JsonSerializable()
class _$_AddBinNotification implements _AddBinNotification {
  _$_AddBinNotification(
      {this.title, this.body, this.imageSrc, this.isBinLive, this.type});

  factory _$_AddBinNotification.fromJson(Map<String, dynamic> json) =>
      _$_$_AddBinNotificationFromJson(json);

  @override
  final String title;
  @override
  final String body;
  @override
  final String imageSrc;
  @override
  final String isBinLive;
  @override
  final NotificationType type;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddBinNotification &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.imageSrc, imageSrc) ||
                const DeepCollectionEquality()
                    .equals(other.imageSrc, imageSrc)) &&
            (identical(other.isBinLive, isBinLive) ||
                const DeepCollectionEquality()
                    .equals(other.isBinLive, isBinLive)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(imageSrc) ^
      const DeepCollectionEquality().hash(isBinLive) ^
      const DeepCollectionEquality().hash(type);

  @override
  _$AddBinNotificationCopyWith<_AddBinNotification> get copyWith =>
      __$AddBinNotificationCopyWithImpl<_AddBinNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AddBinNotificationToJson(this);
  }
}

abstract class _AddBinNotification implements AddBinNotification {
  factory _AddBinNotification(
      {String title,
      String body,
      String imageSrc,
      String isBinLive,
      NotificationType type}) = _$_AddBinNotification;

  factory _AddBinNotification.fromJson(Map<String, dynamic> json) =
      _$_AddBinNotification.fromJson;

  @override
  String get title;
  @override
  String get body;
  @override
  String get imageSrc;
  @override
  String get isBinLive;
  @override
  NotificationType get type;
  @override
  _$AddBinNotificationCopyWith<_AddBinNotification> get copyWith;
}
