import 'dart:convert';

import 'package:equatable/equatable.dart';

class GarbageType extends Equatable {
  String garbageType;
  int count;

  GarbageType({
    this.garbageType,
    this.count,
  });

  @override
  List<Object> get props => [garbageType];

  GarbageType copyWith({
    String garbageType,
    int count,
  }) {
    return GarbageType(
      garbageType: garbageType ?? this.garbageType,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'garbageType': garbageType,
      'count': count,
    };
  }

  static GarbageType fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return GarbageType(
      garbageType: map['garbageType'],
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  static GarbageType fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'GarbageType(garbageType: $garbageType, count: $count)';
}
