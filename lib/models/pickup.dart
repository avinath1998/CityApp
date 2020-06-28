import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:citycollection/models/garbage_type.dart';

class Pickup {
  String id;
  String time;
  String day;
  List<GarbageType> garbageList;

  Pickup({
    this.id,
    this.time,
    this.day,
    this.garbageList,
  });
}
