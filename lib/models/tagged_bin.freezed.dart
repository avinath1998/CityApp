// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'tagged_bin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
TaggedBin _$TaggedBinFromJson(Map<String, dynamic> json) {
  return _TaggedBin.fromJson(json);
}

class _$TaggedBinTearOff {
  const _$TaggedBinTearOff();

  _TaggedBin call(
      {String id,
      String binName,
      String imageSrc,
      String userId,
      bool active,
      bool isNew,
      double locationLan,
      double locationLon,
      double taggedTime,
      int pointsEarned,
      int reportStrikes}) {
    return _TaggedBin(
      id: id,
      binName: binName,
      imageSrc: imageSrc,
      userId: userId,
      active: active,
      isNew: isNew,
      locationLan: locationLan,
      locationLon: locationLon,
      taggedTime: taggedTime,
      pointsEarned: pointsEarned,
      reportStrikes: reportStrikes,
    );
  }
}

// ignore: unused_element
const $TaggedBin = _$TaggedBinTearOff();

mixin _$TaggedBin {
  String get id;
  String get binName;
  String get imageSrc;
  String get userId;
  bool get active;
  bool get isNew;
  double get locationLan;
  double get locationLon;
  double get taggedTime;
  int get pointsEarned;
  int get reportStrikes;

  Map<String, dynamic> toJson();
  $TaggedBinCopyWith<TaggedBin> get copyWith;
}

abstract class $TaggedBinCopyWith<$Res> {
  factory $TaggedBinCopyWith(TaggedBin value, $Res Function(TaggedBin) then) =
      _$TaggedBinCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String binName,
      String imageSrc,
      String userId,
      bool active,
      bool isNew,
      double locationLan,
      double locationLon,
      double taggedTime,
      int pointsEarned,
      int reportStrikes});
}

class _$TaggedBinCopyWithImpl<$Res> implements $TaggedBinCopyWith<$Res> {
  _$TaggedBinCopyWithImpl(this._value, this._then);

  final TaggedBin _value;
  // ignore: unused_field
  final $Res Function(TaggedBin) _then;

  @override
  $Res call({
    Object id = freezed,
    Object binName = freezed,
    Object imageSrc = freezed,
    Object userId = freezed,
    Object active = freezed,
    Object isNew = freezed,
    Object locationLan = freezed,
    Object locationLon = freezed,
    Object taggedTime = freezed,
    Object pointsEarned = freezed,
    Object reportStrikes = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      binName: binName == freezed ? _value.binName : binName as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      userId: userId == freezed ? _value.userId : userId as String,
      active: active == freezed ? _value.active : active as bool,
      isNew: isNew == freezed ? _value.isNew : isNew as bool,
      locationLan:
          locationLan == freezed ? _value.locationLan : locationLan as double,
      locationLon:
          locationLon == freezed ? _value.locationLon : locationLon as double,
      taggedTime:
          taggedTime == freezed ? _value.taggedTime : taggedTime as double,
      pointsEarned:
          pointsEarned == freezed ? _value.pointsEarned : pointsEarned as int,
      reportStrikes: reportStrikes == freezed
          ? _value.reportStrikes
          : reportStrikes as int,
    ));
  }
}

abstract class _$TaggedBinCopyWith<$Res> implements $TaggedBinCopyWith<$Res> {
  factory _$TaggedBinCopyWith(
          _TaggedBin value, $Res Function(_TaggedBin) then) =
      __$TaggedBinCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String binName,
      String imageSrc,
      String userId,
      bool active,
      bool isNew,
      double locationLan,
      double locationLon,
      double taggedTime,
      int pointsEarned,
      int reportStrikes});
}

class __$TaggedBinCopyWithImpl<$Res> extends _$TaggedBinCopyWithImpl<$Res>
    implements _$TaggedBinCopyWith<$Res> {
  __$TaggedBinCopyWithImpl(_TaggedBin _value, $Res Function(_TaggedBin) _then)
      : super(_value, (v) => _then(v as _TaggedBin));

  @override
  _TaggedBin get _value => super._value as _TaggedBin;

  @override
  $Res call({
    Object id = freezed,
    Object binName = freezed,
    Object imageSrc = freezed,
    Object userId = freezed,
    Object active = freezed,
    Object isNew = freezed,
    Object locationLan = freezed,
    Object locationLon = freezed,
    Object taggedTime = freezed,
    Object pointsEarned = freezed,
    Object reportStrikes = freezed,
  }) {
    return _then(_TaggedBin(
      id: id == freezed ? _value.id : id as String,
      binName: binName == freezed ? _value.binName : binName as String,
      imageSrc: imageSrc == freezed ? _value.imageSrc : imageSrc as String,
      userId: userId == freezed ? _value.userId : userId as String,
      active: active == freezed ? _value.active : active as bool,
      isNew: isNew == freezed ? _value.isNew : isNew as bool,
      locationLan:
          locationLan == freezed ? _value.locationLan : locationLan as double,
      locationLon:
          locationLon == freezed ? _value.locationLon : locationLon as double,
      taggedTime:
          taggedTime == freezed ? _value.taggedTime : taggedTime as double,
      pointsEarned:
          pointsEarned == freezed ? _value.pointsEarned : pointsEarned as int,
      reportStrikes: reportStrikes == freezed
          ? _value.reportStrikes
          : reportStrikes as int,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_TaggedBin implements _TaggedBin {
  _$_TaggedBin(
      {this.id,
      this.binName,
      this.imageSrc,
      this.userId,
      this.active,
      this.isNew,
      this.locationLan,
      this.locationLon,
      this.taggedTime,
      this.pointsEarned,
      this.reportStrikes});

  factory _$_TaggedBin.fromJson(Map<String, dynamic> json) =>
      _$_$_TaggedBinFromJson(json);

  @override
  final String id;
  @override
  final String binName;
  @override
  final String imageSrc;
  @override
  final String userId;
  @override
  final bool active;
  @override
  final bool isNew;
  @override
  final double locationLan;
  @override
  final double locationLon;
  @override
  final double taggedTime;
  @override
  final int pointsEarned;
  @override
  final int reportStrikes;

  @override
  String toString() {
    return 'TaggedBin(id: $id, binName: $binName, imageSrc: $imageSrc, userId: $userId, active: $active, isNew: $isNew, locationLan: $locationLan, locationLon: $locationLon, taggedTime: $taggedTime, pointsEarned: $pointsEarned, reportStrikes: $reportStrikes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TaggedBin &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.binName, binName) ||
                const DeepCollectionEquality()
                    .equals(other.binName, binName)) &&
            (identical(other.imageSrc, imageSrc) ||
                const DeepCollectionEquality()
                    .equals(other.imageSrc, imageSrc)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.active, active) ||
                const DeepCollectionEquality().equals(other.active, active)) &&
            (identical(other.isNew, isNew) ||
                const DeepCollectionEquality().equals(other.isNew, isNew)) &&
            (identical(other.locationLan, locationLan) ||
                const DeepCollectionEquality()
                    .equals(other.locationLan, locationLan)) &&
            (identical(other.locationLon, locationLon) ||
                const DeepCollectionEquality()
                    .equals(other.locationLon, locationLon)) &&
            (identical(other.taggedTime, taggedTime) ||
                const DeepCollectionEquality()
                    .equals(other.taggedTime, taggedTime)) &&
            (identical(other.pointsEarned, pointsEarned) ||
                const DeepCollectionEquality()
                    .equals(other.pointsEarned, pointsEarned)) &&
            (identical(other.reportStrikes, reportStrikes) ||
                const DeepCollectionEquality()
                    .equals(other.reportStrikes, reportStrikes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(binName) ^
      const DeepCollectionEquality().hash(imageSrc) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(active) ^
      const DeepCollectionEquality().hash(isNew) ^
      const DeepCollectionEquality().hash(locationLan) ^
      const DeepCollectionEquality().hash(locationLon) ^
      const DeepCollectionEquality().hash(taggedTime) ^
      const DeepCollectionEquality().hash(pointsEarned) ^
      const DeepCollectionEquality().hash(reportStrikes);

  @override
  _$TaggedBinCopyWith<_TaggedBin> get copyWith =>
      __$TaggedBinCopyWithImpl<_TaggedBin>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TaggedBinToJson(this);
  }
}

abstract class _TaggedBin implements TaggedBin {
  factory _TaggedBin(
      {String id,
      String binName,
      String imageSrc,
      String userId,
      bool active,
      bool isNew,
      double locationLan,
      double locationLon,
      double taggedTime,
      int pointsEarned,
      int reportStrikes}) = _$_TaggedBin;

  factory _TaggedBin.fromJson(Map<String, dynamic> json) =
      _$_TaggedBin.fromJson;

  @override
  String get id;
  @override
  String get binName;
  @override
  String get imageSrc;
  @override
  String get userId;
  @override
  bool get active;
  @override
  bool get isNew;
  @override
  double get locationLan;
  @override
  double get locationLon;
  @override
  double get taggedTime;
  @override
  int get pointsEarned;
  @override
  int get reportStrikes;
  @override
  _$TaggedBinCopyWith<_TaggedBin> get copyWith;
}
