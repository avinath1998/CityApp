// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bin_disposal_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BinDisposalEventTearOff {
  const _$BinDisposalEventTearOff();

// ignore: unused_element
  _Started started() {
    return const _Started();
  }

// ignore: unused_element
  _FetchAll fetchAll(CurrentUser user) {
    return _FetchAll(
      user,
    );
  }

// ignore: unused_element
  _Save save(TaggedBin bin, File wasteImage, File binImage, CurrentUser user) {
    return _Save(
      bin,
      wasteImage,
      binImage,
      user,
    );
  }
}

// ignore: unused_element
const $BinDisposalEvent = _$BinDisposalEventTearOff();

mixin _$BinDisposalEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
    @required Result fetchAll(CurrentUser user),
    @required
        Result save(
            TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result fetchAll(CurrentUser user),
    Result save(
        TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
    @required Result fetchAll(_FetchAll value),
    @required Result save(_Save value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result fetchAll(_FetchAll value),
    Result save(_Save value),
    @required Result orElse(),
  });
}

abstract class $BinDisposalEventCopyWith<$Res> {
  factory $BinDisposalEventCopyWith(
          BinDisposalEvent value, $Res Function(BinDisposalEvent) then) =
      _$BinDisposalEventCopyWithImpl<$Res>;
}

class _$BinDisposalEventCopyWithImpl<$Res>
    implements $BinDisposalEventCopyWith<$Res> {
  _$BinDisposalEventCopyWithImpl(this._value, this._then);

  final BinDisposalEvent _value;
  // ignore: unused_field
  final $Res Function(BinDisposalEvent) _then;
}

abstract class _$StartedCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) then) =
      __$StartedCopyWithImpl<$Res>;
}

class __$StartedCopyWithImpl<$Res> extends _$BinDisposalEventCopyWithImpl<$Res>
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
    return 'BinDisposalEvent.started()';
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
    @required Result fetchAll(CurrentUser user),
    @required
        Result save(
            TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
  }) {
    assert(started != null);
    assert(fetchAll != null);
    assert(save != null);
    return started();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result fetchAll(CurrentUser user),
    Result save(
        TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
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
    @required Result fetchAll(_FetchAll value),
    @required Result save(_Save value),
  }) {
    assert(started != null);
    assert(fetchAll != null);
    assert(save != null);
    return started(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result fetchAll(_FetchAll value),
    Result save(_Save value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements BinDisposalEvent {
  const factory _Started() = _$_Started;
}

abstract class _$FetchAllCopyWith<$Res> {
  factory _$FetchAllCopyWith(_FetchAll value, $Res Function(_FetchAll) then) =
      __$FetchAllCopyWithImpl<$Res>;
  $Res call({CurrentUser user});

  $CurrentUserCopyWith<$Res> get user;
}

class __$FetchAllCopyWithImpl<$Res> extends _$BinDisposalEventCopyWithImpl<$Res>
    implements _$FetchAllCopyWith<$Res> {
  __$FetchAllCopyWithImpl(_FetchAll _value, $Res Function(_FetchAll) _then)
      : super(_value, (v) => _then(v as _FetchAll));

  @override
  _FetchAll get _value => super._value as _FetchAll;

  @override
  $Res call({
    Object user = freezed,
  }) {
    return _then(_FetchAll(
      user == freezed ? _value.user : user as CurrentUser,
    ));
  }

  @override
  $CurrentUserCopyWith<$Res> get user {
    if (_value.user == null) {
      return null;
    }
    return $CurrentUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

class _$_FetchAll implements _FetchAll {
  const _$_FetchAll(this.user) : assert(user != null);

  @override
  final CurrentUser user;

  @override
  String toString() {
    return 'BinDisposalEvent.fetchAll(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FetchAll &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @override
  _$FetchAllCopyWith<_FetchAll> get copyWith =>
      __$FetchAllCopyWithImpl<_FetchAll>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
    @required Result fetchAll(CurrentUser user),
    @required
        Result save(
            TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
  }) {
    assert(started != null);
    assert(fetchAll != null);
    assert(save != null);
    return fetchAll(user);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result fetchAll(CurrentUser user),
    Result save(
        TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetchAll != null) {
      return fetchAll(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
    @required Result fetchAll(_FetchAll value),
    @required Result save(_Save value),
  }) {
    assert(started != null);
    assert(fetchAll != null);
    assert(save != null);
    return fetchAll(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result fetchAll(_FetchAll value),
    Result save(_Save value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetchAll != null) {
      return fetchAll(this);
    }
    return orElse();
  }
}

abstract class _FetchAll implements BinDisposalEvent {
  const factory _FetchAll(CurrentUser user) = _$_FetchAll;

  CurrentUser get user;
  _$FetchAllCopyWith<_FetchAll> get copyWith;
}

abstract class _$SaveCopyWith<$Res> {
  factory _$SaveCopyWith(_Save value, $Res Function(_Save) then) =
      __$SaveCopyWithImpl<$Res>;
  $Res call({TaggedBin bin, File wasteImage, File binImage, CurrentUser user});

  $TaggedBinCopyWith<$Res> get bin;
  $CurrentUserCopyWith<$Res> get user;
}

class __$SaveCopyWithImpl<$Res> extends _$BinDisposalEventCopyWithImpl<$Res>
    implements _$SaveCopyWith<$Res> {
  __$SaveCopyWithImpl(_Save _value, $Res Function(_Save) _then)
      : super(_value, (v) => _then(v as _Save));

  @override
  _Save get _value => super._value as _Save;

  @override
  $Res call({
    Object bin = freezed,
    Object wasteImage = freezed,
    Object binImage = freezed,
    Object user = freezed,
  }) {
    return _then(_Save(
      bin == freezed ? _value.bin : bin as TaggedBin,
      wasteImage == freezed ? _value.wasteImage : wasteImage as File,
      binImage == freezed ? _value.binImage : binImage as File,
      user == freezed ? _value.user : user as CurrentUser,
    ));
  }

  @override
  $TaggedBinCopyWith<$Res> get bin {
    if (_value.bin == null) {
      return null;
    }
    return $TaggedBinCopyWith<$Res>(_value.bin, (value) {
      return _then(_value.copyWith(bin: value));
    });
  }

  @override
  $CurrentUserCopyWith<$Res> get user {
    if (_value.user == null) {
      return null;
    }
    return $CurrentUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

class _$_Save implements _Save {
  const _$_Save(this.bin, this.wasteImage, this.binImage, this.user)
      : assert(bin != null),
        assert(wasteImage != null),
        assert(binImage != null),
        assert(user != null);

  @override
  final TaggedBin bin;
  @override
  final File wasteImage;
  @override
  final File binImage;
  @override
  final CurrentUser user;

  @override
  String toString() {
    return 'BinDisposalEvent.save(bin: $bin, wasteImage: $wasteImage, binImage: $binImage, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Save &&
            (identical(other.bin, bin) ||
                const DeepCollectionEquality().equals(other.bin, bin)) &&
            (identical(other.wasteImage, wasteImage) ||
                const DeepCollectionEquality()
                    .equals(other.wasteImage, wasteImage)) &&
            (identical(other.binImage, binImage) ||
                const DeepCollectionEquality()
                    .equals(other.binImage, binImage)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bin) ^
      const DeepCollectionEquality().hash(wasteImage) ^
      const DeepCollectionEquality().hash(binImage) ^
      const DeepCollectionEquality().hash(user);

  @override
  _$SaveCopyWith<_Save> get copyWith =>
      __$SaveCopyWithImpl<_Save>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
    @required Result fetchAll(CurrentUser user),
    @required
        Result save(
            TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
  }) {
    assert(started != null);
    assert(fetchAll != null);
    assert(save != null);
    return save(bin, wasteImage, binImage, user);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    Result fetchAll(CurrentUser user),
    Result save(
        TaggedBin bin, File wasteImage, File binImage, CurrentUser user),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (save != null) {
      return save(bin, wasteImage, binImage, user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
    @required Result fetchAll(_FetchAll value),
    @required Result save(_Save value),
  }) {
    assert(started != null);
    assert(fetchAll != null);
    assert(save != null);
    return save(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    Result fetchAll(_FetchAll value),
    Result save(_Save value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (save != null) {
      return save(this);
    }
    return orElse();
  }
}

abstract class _Save implements BinDisposalEvent {
  const factory _Save(
          TaggedBin bin, File wasteImage, File binImage, CurrentUser user) =
      _$_Save;

  TaggedBin get bin;
  File get wasteImage;
  File get binImage;
  CurrentUser get user;
  _$SaveCopyWith<_Save> get copyWith;
}

class _$BinDisposalStateTearOff {
  const _$BinDisposalStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _BinDisposalsLoaded binDisposalsLoaded(List<BinDisposal> disposals) {
    return _BinDisposalsLoaded(
      disposals,
    );
  }

// ignore: unused_element
  _BinDisposalsLoading binDisposalsLoading() {
    return const _BinDisposalsLoading();
  }

// ignore: unused_element
  _BinDisposalsFailedLoading binDisposalsFailedLoading() {
    return const _BinDisposalsFailedLoading();
  }

// ignore: unused_element
  _BinDisposalFailedSaving binDisposalFailedSaving(Exception e) {
    return _BinDisposalFailedSaving(
      e,
    );
  }

// ignore: unused_element
  _BinDisposalSaved binDisposalSaved(BinDisposal disposal) {
    return _BinDisposalSaved(
      disposal,
    );
  }

// ignore: unused_element
  _BinDisposalSaving binDisposalSaving() {
    return const _BinDisposalSaving();
  }
}

// ignore: unused_element
const $BinDisposalState = _$BinDisposalStateTearOff();

mixin _$BinDisposalState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  });
}

abstract class $BinDisposalStateCopyWith<$Res> {
  factory $BinDisposalStateCopyWith(
          BinDisposalState value, $Res Function(BinDisposalState) then) =
      _$BinDisposalStateCopyWithImpl<$Res>;
}

class _$BinDisposalStateCopyWithImpl<$Res>
    implements $BinDisposalStateCopyWith<$Res> {
  _$BinDisposalStateCopyWithImpl(this._value, this._then);

  final BinDisposalState _value;
  // ignore: unused_field
  final $Res Function(BinDisposalState) _then;
}

abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

class __$InitialCopyWithImpl<$Res> extends _$BinDisposalStateCopyWithImpl<$Res>
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
    return 'BinDisposalState.initial()';
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
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
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
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements BinDisposalState {
  const factory _Initial() = _$_Initial;
}

abstract class _$BinDisposalsLoadedCopyWith<$Res> {
  factory _$BinDisposalsLoadedCopyWith(
          _BinDisposalsLoaded value, $Res Function(_BinDisposalsLoaded) then) =
      __$BinDisposalsLoadedCopyWithImpl<$Res>;
  $Res call({List<BinDisposal> disposals});
}

class __$BinDisposalsLoadedCopyWithImpl<$Res>
    extends _$BinDisposalStateCopyWithImpl<$Res>
    implements _$BinDisposalsLoadedCopyWith<$Res> {
  __$BinDisposalsLoadedCopyWithImpl(
      _BinDisposalsLoaded _value, $Res Function(_BinDisposalsLoaded) _then)
      : super(_value, (v) => _then(v as _BinDisposalsLoaded));

  @override
  _BinDisposalsLoaded get _value => super._value as _BinDisposalsLoaded;

  @override
  $Res call({
    Object disposals = freezed,
  }) {
    return _then(_BinDisposalsLoaded(
      disposals == freezed ? _value.disposals : disposals as List<BinDisposal>,
    ));
  }
}

class _$_BinDisposalsLoaded implements _BinDisposalsLoaded {
  const _$_BinDisposalsLoaded(this.disposals) : assert(disposals != null);

  @override
  final List<BinDisposal> disposals;

  @override
  String toString() {
    return 'BinDisposalState.binDisposalsLoaded(disposals: $disposals)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BinDisposalsLoaded &&
            (identical(other.disposals, disposals) ||
                const DeepCollectionEquality()
                    .equals(other.disposals, disposals)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(disposals);

  @override
  _$BinDisposalsLoadedCopyWith<_BinDisposalsLoaded> get copyWith =>
      __$BinDisposalsLoadedCopyWithImpl<_BinDisposalsLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalsLoaded(disposals);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalsLoaded != null) {
      return binDisposalsLoaded(disposals);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalsLoaded(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalsLoaded != null) {
      return binDisposalsLoaded(this);
    }
    return orElse();
  }
}

abstract class _BinDisposalsLoaded implements BinDisposalState {
  const factory _BinDisposalsLoaded(List<BinDisposal> disposals) =
      _$_BinDisposalsLoaded;

  List<BinDisposal> get disposals;
  _$BinDisposalsLoadedCopyWith<_BinDisposalsLoaded> get copyWith;
}

abstract class _$BinDisposalsLoadingCopyWith<$Res> {
  factory _$BinDisposalsLoadingCopyWith(_BinDisposalsLoading value,
          $Res Function(_BinDisposalsLoading) then) =
      __$BinDisposalsLoadingCopyWithImpl<$Res>;
}

class __$BinDisposalsLoadingCopyWithImpl<$Res>
    extends _$BinDisposalStateCopyWithImpl<$Res>
    implements _$BinDisposalsLoadingCopyWith<$Res> {
  __$BinDisposalsLoadingCopyWithImpl(
      _BinDisposalsLoading _value, $Res Function(_BinDisposalsLoading) _then)
      : super(_value, (v) => _then(v as _BinDisposalsLoading));

  @override
  _BinDisposalsLoading get _value => super._value as _BinDisposalsLoading;
}

class _$_BinDisposalsLoading implements _BinDisposalsLoading {
  const _$_BinDisposalsLoading();

  @override
  String toString() {
    return 'BinDisposalState.binDisposalsLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _BinDisposalsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalsLoading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalsLoading != null) {
      return binDisposalsLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalsLoading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalsLoading != null) {
      return binDisposalsLoading(this);
    }
    return orElse();
  }
}

abstract class _BinDisposalsLoading implements BinDisposalState {
  const factory _BinDisposalsLoading() = _$_BinDisposalsLoading;
}

abstract class _$BinDisposalsFailedLoadingCopyWith<$Res> {
  factory _$BinDisposalsFailedLoadingCopyWith(_BinDisposalsFailedLoading value,
          $Res Function(_BinDisposalsFailedLoading) then) =
      __$BinDisposalsFailedLoadingCopyWithImpl<$Res>;
}

class __$BinDisposalsFailedLoadingCopyWithImpl<$Res>
    extends _$BinDisposalStateCopyWithImpl<$Res>
    implements _$BinDisposalsFailedLoadingCopyWith<$Res> {
  __$BinDisposalsFailedLoadingCopyWithImpl(_BinDisposalsFailedLoading _value,
      $Res Function(_BinDisposalsFailedLoading) _then)
      : super(_value, (v) => _then(v as _BinDisposalsFailedLoading));

  @override
  _BinDisposalsFailedLoading get _value =>
      super._value as _BinDisposalsFailedLoading;
}

class _$_BinDisposalsFailedLoading implements _BinDisposalsFailedLoading {
  const _$_BinDisposalsFailedLoading();

  @override
  String toString() {
    return 'BinDisposalState.binDisposalsFailedLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _BinDisposalsFailedLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalsFailedLoading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalsFailedLoading != null) {
      return binDisposalsFailedLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalsFailedLoading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalsFailedLoading != null) {
      return binDisposalsFailedLoading(this);
    }
    return orElse();
  }
}

abstract class _BinDisposalsFailedLoading implements BinDisposalState {
  const factory _BinDisposalsFailedLoading() = _$_BinDisposalsFailedLoading;
}

abstract class _$BinDisposalFailedSavingCopyWith<$Res> {
  factory _$BinDisposalFailedSavingCopyWith(_BinDisposalFailedSaving value,
          $Res Function(_BinDisposalFailedSaving) then) =
      __$BinDisposalFailedSavingCopyWithImpl<$Res>;
  $Res call({Exception e});
}

class __$BinDisposalFailedSavingCopyWithImpl<$Res>
    extends _$BinDisposalStateCopyWithImpl<$Res>
    implements _$BinDisposalFailedSavingCopyWith<$Res> {
  __$BinDisposalFailedSavingCopyWithImpl(_BinDisposalFailedSaving _value,
      $Res Function(_BinDisposalFailedSaving) _then)
      : super(_value, (v) => _then(v as _BinDisposalFailedSaving));

  @override
  _BinDisposalFailedSaving get _value =>
      super._value as _BinDisposalFailedSaving;

  @override
  $Res call({
    Object e = freezed,
  }) {
    return _then(_BinDisposalFailedSaving(
      e == freezed ? _value.e : e as Exception,
    ));
  }
}

class _$_BinDisposalFailedSaving implements _BinDisposalFailedSaving {
  const _$_BinDisposalFailedSaving(this.e) : assert(e != null);

  @override
  final Exception e;

  @override
  String toString() {
    return 'BinDisposalState.binDisposalFailedSaving(e: $e)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BinDisposalFailedSaving &&
            (identical(other.e, e) ||
                const DeepCollectionEquality().equals(other.e, e)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(e);

  @override
  _$BinDisposalFailedSavingCopyWith<_BinDisposalFailedSaving> get copyWith =>
      __$BinDisposalFailedSavingCopyWithImpl<_BinDisposalFailedSaving>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalFailedSaving(e);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalFailedSaving != null) {
      return binDisposalFailedSaving(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalFailedSaving(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalFailedSaving != null) {
      return binDisposalFailedSaving(this);
    }
    return orElse();
  }
}

abstract class _BinDisposalFailedSaving implements BinDisposalState {
  const factory _BinDisposalFailedSaving(Exception e) =
      _$_BinDisposalFailedSaving;

  Exception get e;
  _$BinDisposalFailedSavingCopyWith<_BinDisposalFailedSaving> get copyWith;
}

abstract class _$BinDisposalSavedCopyWith<$Res> {
  factory _$BinDisposalSavedCopyWith(
          _BinDisposalSaved value, $Res Function(_BinDisposalSaved) then) =
      __$BinDisposalSavedCopyWithImpl<$Res>;
  $Res call({BinDisposal disposal});

  $BinDisposalCopyWith<$Res> get disposal;
}

class __$BinDisposalSavedCopyWithImpl<$Res>
    extends _$BinDisposalStateCopyWithImpl<$Res>
    implements _$BinDisposalSavedCopyWith<$Res> {
  __$BinDisposalSavedCopyWithImpl(
      _BinDisposalSaved _value, $Res Function(_BinDisposalSaved) _then)
      : super(_value, (v) => _then(v as _BinDisposalSaved));

  @override
  _BinDisposalSaved get _value => super._value as _BinDisposalSaved;

  @override
  $Res call({
    Object disposal = freezed,
  }) {
    return _then(_BinDisposalSaved(
      disposal == freezed ? _value.disposal : disposal as BinDisposal,
    ));
  }

  @override
  $BinDisposalCopyWith<$Res> get disposal {
    if (_value.disposal == null) {
      return null;
    }
    return $BinDisposalCopyWith<$Res>(_value.disposal, (value) {
      return _then(_value.copyWith(disposal: value));
    });
  }
}

class _$_BinDisposalSaved implements _BinDisposalSaved {
  const _$_BinDisposalSaved(this.disposal) : assert(disposal != null);

  @override
  final BinDisposal disposal;

  @override
  String toString() {
    return 'BinDisposalState.binDisposalSaved(disposal: $disposal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BinDisposalSaved &&
            (identical(other.disposal, disposal) ||
                const DeepCollectionEquality()
                    .equals(other.disposal, disposal)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(disposal);

  @override
  _$BinDisposalSavedCopyWith<_BinDisposalSaved> get copyWith =>
      __$BinDisposalSavedCopyWithImpl<_BinDisposalSaved>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalSaved(disposal);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalSaved != null) {
      return binDisposalSaved(disposal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalSaved(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalSaved != null) {
      return binDisposalSaved(this);
    }
    return orElse();
  }
}

abstract class _BinDisposalSaved implements BinDisposalState {
  const factory _BinDisposalSaved(BinDisposal disposal) = _$_BinDisposalSaved;

  BinDisposal get disposal;
  _$BinDisposalSavedCopyWith<_BinDisposalSaved> get copyWith;
}

abstract class _$BinDisposalSavingCopyWith<$Res> {
  factory _$BinDisposalSavingCopyWith(
          _BinDisposalSaving value, $Res Function(_BinDisposalSaving) then) =
      __$BinDisposalSavingCopyWithImpl<$Res>;
}

class __$BinDisposalSavingCopyWithImpl<$Res>
    extends _$BinDisposalStateCopyWithImpl<$Res>
    implements _$BinDisposalSavingCopyWith<$Res> {
  __$BinDisposalSavingCopyWithImpl(
      _BinDisposalSaving _value, $Res Function(_BinDisposalSaving) _then)
      : super(_value, (v) => _then(v as _BinDisposalSaving));

  @override
  _BinDisposalSaving get _value => super._value as _BinDisposalSaving;
}

class _$_BinDisposalSaving implements _BinDisposalSaving {
  const _$_BinDisposalSaving();

  @override
  String toString() {
    return 'BinDisposalState.binDisposalSaving()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _BinDisposalSaving);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result binDisposalsLoaded(List<BinDisposal> disposals),
    @required Result binDisposalsLoading(),
    @required Result binDisposalsFailedLoading(),
    @required Result binDisposalFailedSaving(Exception e),
    @required Result binDisposalSaved(BinDisposal disposal),
    @required Result binDisposalSaving(),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalSaving();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result binDisposalsLoaded(List<BinDisposal> disposals),
    Result binDisposalsLoading(),
    Result binDisposalsFailedLoading(),
    Result binDisposalFailedSaving(Exception e),
    Result binDisposalSaved(BinDisposal disposal),
    Result binDisposalSaving(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalSaving != null) {
      return binDisposalSaving();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result binDisposalsLoaded(_BinDisposalsLoaded value),
    @required Result binDisposalsLoading(_BinDisposalsLoading value),
    @required
        Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    @required Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    @required Result binDisposalSaved(_BinDisposalSaved value),
    @required Result binDisposalSaving(_BinDisposalSaving value),
  }) {
    assert(initial != null);
    assert(binDisposalsLoaded != null);
    assert(binDisposalsLoading != null);
    assert(binDisposalsFailedLoading != null);
    assert(binDisposalFailedSaving != null);
    assert(binDisposalSaved != null);
    assert(binDisposalSaving != null);
    return binDisposalSaving(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result binDisposalsLoaded(_BinDisposalsLoaded value),
    Result binDisposalsLoading(_BinDisposalsLoading value),
    Result binDisposalsFailedLoading(_BinDisposalsFailedLoading value),
    Result binDisposalFailedSaving(_BinDisposalFailedSaving value),
    Result binDisposalSaved(_BinDisposalSaved value),
    Result binDisposalSaving(_BinDisposalSaving value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (binDisposalSaving != null) {
      return binDisposalSaving(this);
    }
    return orElse();
  }
}

abstract class _BinDisposalSaving implements BinDisposalState {
  const factory _BinDisposalSaving() = _$_BinDisposalSaving;
}
