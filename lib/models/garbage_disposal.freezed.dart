// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'garbage_disposal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
GarbageDisposal _$GarbageDisposalFromJson(Map<String, dynamic> json) {
  return _GarbageDisposal.fromJson(json);
}

class _$GarbageDisposalTearOff {
  const _$GarbageDisposalTearOff();

  _GarbageDisposal call(
      {@required String id, @required String type, int count, double weight}) {
    return _GarbageDisposal(
      id: id,
      type: type,
      count: count,
      weight: weight,
    );
  }
}

// ignore: unused_element
const $GarbageDisposal = _$GarbageDisposalTearOff();

mixin _$GarbageDisposal {
  String get id;
  String get type;
  int get count;
  double get weight;

  Map<String, dynamic> toJson();
  $GarbageDisposalCopyWith<GarbageDisposal> get copyWith;
}

abstract class $GarbageDisposalCopyWith<$Res> {
  factory $GarbageDisposalCopyWith(
          GarbageDisposal value, $Res Function(GarbageDisposal) then) =
      _$GarbageDisposalCopyWithImpl<$Res>;
  $Res call({String id, String type, int count, double weight});
}

class _$GarbageDisposalCopyWithImpl<$Res>
    implements $GarbageDisposalCopyWith<$Res> {
  _$GarbageDisposalCopyWithImpl(this._value, this._then);

  final GarbageDisposal _value;
  // ignore: unused_field
  final $Res Function(GarbageDisposal) _then;

  @override
  $Res call({
    Object id = freezed,
    Object type = freezed,
    Object count = freezed,
    Object weight = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as String,
      count: count == freezed ? _value.count : count as int,
      weight: weight == freezed ? _value.weight : weight as double,
    ));
  }
}

abstract class _$GarbageDisposalCopyWith<$Res>
    implements $GarbageDisposalCopyWith<$Res> {
  factory _$GarbageDisposalCopyWith(
          _GarbageDisposal value, $Res Function(_GarbageDisposal) then) =
      __$GarbageDisposalCopyWithImpl<$Res>;
  @override
  $Res call({String id, String type, int count, double weight});
}

class __$GarbageDisposalCopyWithImpl<$Res>
    extends _$GarbageDisposalCopyWithImpl<$Res>
    implements _$GarbageDisposalCopyWith<$Res> {
  __$GarbageDisposalCopyWithImpl(
      _GarbageDisposal _value, $Res Function(_GarbageDisposal) _then)
      : super(_value, (v) => _then(v as _GarbageDisposal));

  @override
  _GarbageDisposal get _value => super._value as _GarbageDisposal;

  @override
  $Res call({
    Object id = freezed,
    Object type = freezed,
    Object count = freezed,
    Object weight = freezed,
  }) {
    return _then(_GarbageDisposal(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as String,
      count: count == freezed ? _value.count : count as int,
      weight: weight == freezed ? _value.weight : weight as double,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$_GarbageDisposal implements _GarbageDisposal {
  _$_GarbageDisposal(
      {@required this.id, @required this.type, this.count, this.weight})
      : assert(id != null),
        assert(type != null);

  factory _$_GarbageDisposal.fromJson(Map<String, dynamic> json) =>
      _$_$_GarbageDisposalFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final int count;
  @override
  final double weight;

  @override
  String toString() {
    return 'GarbageDisposal(id: $id, type: $type, count: $count, weight: $weight)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GarbageDisposal &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)) &&
            (identical(other.weight, weight) ||
                const DeepCollectionEquality().equals(other.weight, weight)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(count) ^
      const DeepCollectionEquality().hash(weight);

  @override
  _$GarbageDisposalCopyWith<_GarbageDisposal> get copyWith =>
      __$GarbageDisposalCopyWithImpl<_GarbageDisposal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GarbageDisposalToJson(this);
  }
}

abstract class _GarbageDisposal implements GarbageDisposal {
  factory _GarbageDisposal(
      {@required String id,
      @required String type,
      int count,
      double weight}) = _$_GarbageDisposal;

  factory _GarbageDisposal.fromJson(Map<String, dynamic> json) =
      _$_GarbageDisposal.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  int get count;
  @override
  double get weight;
  @override
  _$GarbageDisposalCopyWith<_GarbageDisposal> get copyWith;
}
