import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:citycollection/models/redemption.dart';
import 'package:citycollection/models/pick_up.dart';

import 'package:citycollection/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_user.freezed.dart';
part 'current_user.g.dart';

@freezed
abstract class CurrentUser extends User with _$CurrentUser {
  @JsonSerializable(explicitToJson: true)
  factory CurrentUser(
      {String address,
      DateTime dob,
      int points,
      List<Pickup> pickups,
      List<Redemption> redemptions,
      String id,
      String name,
      String email,
      String phoneNumber,
      String password,
      UserType userType}) = _CurrentUser;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
}
