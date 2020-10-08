// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$LocationEventTearOff {
  const _$LocationEventTearOff();

// ignore: unused_element
  _Started started() {
    return const _Started();
  }

// ignore: unused_element
  _LoadLocationEvent loadLocationEvent() {
    return const _LoadLocationEvent();
  }
}

// ignore: unused_element
const $LocationEvent = _$LocationEventTearOff();

mixin _$LocationEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
    @required Result loadLocationEvent(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result loadLocationEvent(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
    @required Result loadLocationEvent(_LoadLocationEvent value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result loadLocationEvent(_LoadLocationEvent value),
    @required Result orElse(),
  });
}

abstract class $LocationEventCopyWith<$Res> {
  factory $LocationEventCopyWith(
          LocationEvent value, $Res Function(LocationEvent) then) =
      _$LocationEventCopyWithImpl<$Res>;
}

class _$LocationEventCopyWithImpl<$Res>
    implements $LocationEventCopyWith<$Res> {
  _$LocationEventCopyWithImpl(this._value, this._then);

  final LocationEvent _value;
  // ignore: unused_field
  final $Res Function(LocationEvent) _then;
}

abstract class _$StartedCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) then) =
      __$StartedCopyWithImpl<$Res>;
}

class __$StartedCopyWithImpl<$Res> extends _$LocationEventCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(_Started _value, $Res Function(_Started) _then)
      : super(_value, (v) => _then(v as _Started));

  @override
  _Started get _value => super._value as _Started;
}

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'LocationEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
    @required Result loadLocationEvent(),
  }) {
    assert(started != null);
    assert(loadLocationEvent != null);
    return started();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result loadLocationEvent(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
    @required Result loadLocationEvent(_LoadLocationEvent value),
  }) {
    assert(started != null);
    assert(loadLocationEvent != null);
    return started(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result loadLocationEvent(_LoadLocationEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements LocationEvent {
  const factory _Started() = _$_Started;
}

abstract class _$LoadLocationEventCopyWith<$Res> {
  factory _$LoadLocationEventCopyWith(
          _LoadLocationEvent value, $Res Function(_LoadLocationEvent) then) =
      __$LoadLocationEventCopyWithImpl<$Res>;
}

class __$LoadLocationEventCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res>
    implements _$LoadLocationEventCopyWith<$Res> {
  __$LoadLocationEventCopyWithImpl(
      _LoadLocationEvent _value, $Res Function(_LoadLocationEvent) _then)
      : super(_value, (v) => _then(v as _LoadLocationEvent));

  @override
  _LoadLocationEvent get _value => super._value as _LoadLocationEvent;
}

class _$_LoadLocationEvent implements _LoadLocationEvent {
  const _$_LoadLocationEvent();

  @override
  String toString() {
    return 'LocationEvent.loadLocationEvent()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LoadLocationEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
    @required Result loadLocationEvent(),
  }) {
    assert(started != null);
    assert(loadLocationEvent != null);
    return loadLocationEvent();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result loadLocationEvent(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadLocationEvent != null) {
      return loadLocationEvent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
    @required Result loadLocationEvent(_LoadLocationEvent value),
  }) {
    assert(started != null);
    assert(loadLocationEvent != null);
    return loadLocationEvent(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result loadLocationEvent(_LoadLocationEvent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadLocationEvent != null) {
      return loadLocationEvent(this);
    }
    return orElse();
  }
}

abstract class _LoadLocationEvent implements LocationEvent {
  const factory _LoadLocationEvent() = _$_LoadLocationEvent;
}

class _$LocationStateTearOff {
  const _$LocationStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _LoadingLocationState loadingLocationState() {
    return const _LoadingLocationState();
  }

// ignore: unused_element
  _LoadedLocationState loadedLocationState(
      Position position, List<Address> addressname) {
    return _LoadedLocationState(
      position,
      addressname,
    );
  }

// ignore: unused_element
  _FailedLoaingLocationState failedLoadingLocationState() {
    return const _FailedLoaingLocationState();
  }

// ignore: unused_element
  _LocationDisabledState locationDisabledState() {
    return const _LocationDisabledState();
  }

// ignore: unused_element
  _LocationDeniedState locationDeniedState() {
    return const _LocationDeniedState();
  }
}

// ignore: unused_element
const $LocationState = _$LocationStateTearOff();

mixin _$LocationState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  });
}

abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
          LocationState value, $Res Function(LocationState) then) =
      _$LocationStateCopyWithImpl<$Res>;
}

class _$LocationStateCopyWithImpl<$Res>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  final LocationState _value;
  // ignore: unused_field
  final $Res Function(LocationState) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$LocationStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'LocationState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LocationState {
  const factory _Initial() = _$_Initial;
}

abstract class _$LoadingLocationStateCopyWith<$Res> {
  factory _$LoadingLocationStateCopyWith(_LoadingLocationState value,
          $Res Function(_LoadingLocationState) then) =
      __$LoadingLocationStateCopyWithImpl<$Res>;
}

class __$LoadingLocationStateCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res>
    implements _$LoadingLocationStateCopyWith<$Res> {
  __$LoadingLocationStateCopyWithImpl(
      _LoadingLocationState _value, $Res Function(_LoadingLocationState) _then)
      : super(_value, (v) => _then(v as _LoadingLocationState));

  @override
  _LoadingLocationState get _value => super._value as _LoadingLocationState;
}

class _$_LoadingLocationState implements _LoadingLocationState {
  const _$_LoadingLocationState();

  @override
  String toString() {
    return 'LocationState.loadingLocationState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LoadingLocationState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return loadingLocationState();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadingLocationState != null) {
      return loadingLocationState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return loadingLocationState(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadingLocationState != null) {
      return loadingLocationState(this);
    }
    return orElse();
  }
}

abstract class _LoadingLocationState implements LocationState {
  const factory _LoadingLocationState() = _$_LoadingLocationState;
}

abstract class _$LoadedLocationStateCopyWith<$Res> {
  factory _$LoadedLocationStateCopyWith(_LoadedLocationState value,
          $Res Function(_LoadedLocationState) then) =
      __$LoadedLocationStateCopyWithImpl<$Res>;
  $Res call({Position position, List<Address> addressname});
}

class __$LoadedLocationStateCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res>
    implements _$LoadedLocationStateCopyWith<$Res> {
  __$LoadedLocationStateCopyWithImpl(
      _LoadedLocationState _value, $Res Function(_LoadedLocationState) _then)
      : super(_value, (v) => _then(v as _LoadedLocationState));

  @override
  _LoadedLocationState get _value => super._value as _LoadedLocationState;

  @override
  $Res call({
    Object position = freezed,
    Object addressname = freezed,
  }) {
    return _then(_LoadedLocationState(
      position == freezed ? _value.position : position as Position,
      addressname == freezed
          ? _value.addressname
          : addressname as List<Address>,
    ));
  }
}

class _$_LoadedLocationState implements _LoadedLocationState {
  const _$_LoadedLocationState(this.position, this.addressname)
      : assert(position != null),
        assert(addressname != null);

  @override
  final Position position;
  @override
  final List<Address> addressname;

  @override
  String toString() {
    return 'LocationState.loadedLocationState(position: $position, addressname: $addressname)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoadedLocationState &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.addressname, addressname) ||
                const DeepCollectionEquality()
                    .equals(other.addressname, addressname)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(addressname);

  @override
  _$LoadedLocationStateCopyWith<_LoadedLocationState> get copyWith =>
      __$LoadedLocationStateCopyWithImpl<_LoadedLocationState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return loadedLocationState(position, addressname);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadedLocationState != null) {
      return loadedLocationState(position, addressname);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return loadedLocationState(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadedLocationState != null) {
      return loadedLocationState(this);
    }
    return orElse();
  }
}

abstract class _LoadedLocationState implements LocationState {
  const factory _LoadedLocationState(
      Position position, List<Address> addressname) = _$_LoadedLocationState;

  Position get position;
  List<Address> get addressname;
  _$LoadedLocationStateCopyWith<_LoadedLocationState> get copyWith;
}

abstract class _$FailedLoaingLocationStateCopyWith<$Res> {
  factory _$FailedLoaingLocationStateCopyWith(_FailedLoaingLocationState value,
          $Res Function(_FailedLoaingLocationState) then) =
      __$FailedLoaingLocationStateCopyWithImpl<$Res>;
}

class __$FailedLoaingLocationStateCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res>
    implements _$FailedLoaingLocationStateCopyWith<$Res> {
  __$FailedLoaingLocationStateCopyWithImpl(_FailedLoaingLocationState _value,
      $Res Function(_FailedLoaingLocationState) _then)
      : super(_value, (v) => _then(v as _FailedLoaingLocationState));

  @override
  _FailedLoaingLocationState get _value =>
      super._value as _FailedLoaingLocationState;
}

class _$_FailedLoaingLocationState implements _FailedLoaingLocationState {
  const _$_FailedLoaingLocationState();

  @override
  String toString() {
    return 'LocationState.failedLoadingLocationState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _FailedLoaingLocationState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return failedLoadingLocationState();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (failedLoadingLocationState != null) {
      return failedLoadingLocationState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return failedLoadingLocationState(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (failedLoadingLocationState != null) {
      return failedLoadingLocationState(this);
    }
    return orElse();
  }
}

abstract class _FailedLoaingLocationState implements LocationState {
  const factory _FailedLoaingLocationState() = _$_FailedLoaingLocationState;
}

abstract class _$LocationDisabledStateCopyWith<$Res> {
  factory _$LocationDisabledStateCopyWith(_LocationDisabledState value,
          $Res Function(_LocationDisabledState) then) =
      __$LocationDisabledStateCopyWithImpl<$Res>;
}

class __$LocationDisabledStateCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res>
    implements _$LocationDisabledStateCopyWith<$Res> {
  __$LocationDisabledStateCopyWithImpl(_LocationDisabledState _value,
      $Res Function(_LocationDisabledState) _then)
      : super(_value, (v) => _then(v as _LocationDisabledState));

  @override
  _LocationDisabledState get _value => super._value as _LocationDisabledState;
}

class _$_LocationDisabledState implements _LocationDisabledState {
  const _$_LocationDisabledState();

  @override
  String toString() {
    return 'LocationState.locationDisabledState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LocationDisabledState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return locationDisabledState();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (locationDisabledState != null) {
      return locationDisabledState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return locationDisabledState(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (locationDisabledState != null) {
      return locationDisabledState(this);
    }
    return orElse();
  }
}

abstract class _LocationDisabledState implements LocationState {
  const factory _LocationDisabledState() = _$_LocationDisabledState;
}

abstract class _$LocationDeniedStateCopyWith<$Res> {
  factory _$LocationDeniedStateCopyWith(_LocationDeniedState value,
          $Res Function(_LocationDeniedState) then) =
      __$LocationDeniedStateCopyWithImpl<$Res>;
}

class __$LocationDeniedStateCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res>
    implements _$LocationDeniedStateCopyWith<$Res> {
  __$LocationDeniedStateCopyWithImpl(
      _LocationDeniedState _value, $Res Function(_LocationDeniedState) _then)
      : super(_value, (v) => _then(v as _LocationDeniedState));

  @override
  _LocationDeniedState get _value => super._value as _LocationDeniedState;
}

class _$_LocationDeniedState implements _LocationDeniedState {
  const _$_LocationDeniedState();

  @override
  String toString() {
    return 'LocationState.locationDeniedState()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LocationDeniedState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result loadingLocationState(),
    @required
        Result loadedLocationState(
            Position position, List<Address> addressname),
    @required Result failedLoadingLocationState(),
    @required Result locationDisabledState(),
    @required Result locationDeniedState(),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return locationDeniedState();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result loadingLocationState(),
    Result loadedLocationState(Position position, List<Address> addressname),
    Result failedLoadingLocationState(),
    Result locationDisabledState(),
    Result locationDeniedState(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (locationDeniedState != null) {
      return locationDeniedState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result loadingLocationState(_LoadingLocationState value),
    @required Result loadedLocationState(_LoadedLocationState value),
    @required
        Result failedLoadingLocationState(_FailedLoaingLocationState value),
    @required Result locationDisabledState(_LocationDisabledState value),
    @required Result locationDeniedState(_LocationDeniedState value),
  }) {
    assert(initial != null);
    assert(loadingLocationState != null);
    assert(loadedLocationState != null);
    assert(failedLoadingLocationState != null);
    assert(locationDisabledState != null);
    assert(locationDeniedState != null);
    return locationDeniedState(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result loadingLocationState(_LoadingLocationState value),
    Result loadedLocationState(_LoadedLocationState value),
    Result failedLoadingLocationState(_FailedLoaingLocationState value),
    Result locationDisabledState(_LocationDisabledState value),
    Result locationDeniedState(_LocationDeniedState value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (locationDeniedState != null) {
      return locationDeniedState(this);
    }
    return orElse();
  }
}

abstract class _LocationDeniedState implements LocationState {
  const factory _LocationDeniedState() = _$_LocationDeniedState;
}
