// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'general_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
GeneralNotification _$GeneralNotificationFromJson(Map<String, dynamic> json) {
  return _GeneralNotification.fromJson(json);
}

class _$GeneralNotificationTearOff {
  const _$GeneralNotificationTearOff();

// ignore: unused_element
  _GeneralNotification call(
      {String title, String body, NotificationType type}) {
    return _GeneralNotification(
      title: title,
      body: body,
      type: type,
    );
  }
}

// ignore: unused_element
const $GeneralNotification = _$GeneralNotificationTearOff();

mixin _$GeneralNotification {
  String get title;
  String get body;
  NotificationType get type;

  Map<String, dynamic> toJson();
  $GeneralNotificationCopyWith<GeneralNotification> get copyWith;
}

abstract class $GeneralNotificationCopyWith<$Res> {
  factory $GeneralNotificationCopyWith(
          GeneralNotification value, $Res Function(GeneralNotification) then) =
      _$GeneralNotificationCopyWithImpl<$Res>;
  $Res call({String title, String body, NotificationType type});
}

class _$GeneralNotificationCopyWithImpl<$Res>
    implements $GeneralNotificationCopyWith<$Res> {
  _$GeneralNotificationCopyWithImpl(this._value, this._then);

  final GeneralNotification _value;
  // ignore: unused_field
  final $Res Function(GeneralNotification) _then;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

abstract class _$GeneralNotificationCopyWith<$Res>
    implements $GeneralNotificationCopyWith<$Res> {
  factory _$GeneralNotificationCopyWith(_GeneralNotification value,
          $Res Function(_GeneralNotification) then) =
      __$GeneralNotificationCopyWithImpl<$Res>;
  @override
  $Res call({String title, String body, NotificationType type});
}

class __$GeneralNotificationCopyWithImpl<$Res>
    extends _$GeneralNotificationCopyWithImpl<$Res>
    implements _$GeneralNotificationCopyWith<$Res> {
  __$GeneralNotificationCopyWithImpl(
      _GeneralNotification _value, $Res Function(_GeneralNotification) _then)
      : super(_value, (v) => _then(v as _GeneralNotification));

  @override
  _GeneralNotification get _value => super._value as _GeneralNotification;

  @override
  $Res call({
    Object title = freezed,
    Object body = freezed,
    Object type = freezed,
  }) {
    return _then(_GeneralNotification(
      title: title == freezed ? _value.title : title as String,
      body: body == freezed ? _value.body : body as String,
      type: type == freezed ? _value.type : type as NotificationType,
    ));
  }
}

@JsonSerializable()
class _$_GeneralNotification implements _GeneralNotification {
  _$_GeneralNotification({this.title, this.body, this.type});

  factory _$_GeneralNotification.fromJson(Map<String, dynamic> json) =>
      _$_$_GeneralNotificationFromJson(json);

  @override
  final String title;
  @override
  final String body;
  @override
  final NotificationType type;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GeneralNotification &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(type);

  @override
  _$GeneralNotificationCopyWith<_GeneralNotification> get copyWith =>
      __$GeneralNotificationCopyWithImpl<_GeneralNotification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GeneralNotificationToJson(this);
  }
}

abstract class _GeneralNotification implements GeneralNotification {
  factory _GeneralNotification(
      {String title,
      String body,
      NotificationType type}) = _$_GeneralNotification;

  factory _GeneralNotification.fromJson(Map<String, dynamic> json) =
      _$_GeneralNotification.fromJson;

  @override
  String get title;
  @override
  String get body;
  @override
  NotificationType get type;
  @override
  _$GeneralNotificationCopyWith<_GeneralNotification> get copyWith;
}
