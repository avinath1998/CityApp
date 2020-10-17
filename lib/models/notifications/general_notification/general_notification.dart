import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../base_notification.dart';

part 'general_notification.freezed.dart';
part 'general_notification.g.dart';

@freezed
abstract class GeneralNotification extends BaseNotification
    with _$GeneralNotification {
  factory GeneralNotification({
    String title,
    String body,
    NotificationType type,
  }) = _GeneralNotification;

  factory GeneralNotification.fromJson(Map<String, dynamic> json) =>
      _$GeneralNotificationFromJson(json);
}
