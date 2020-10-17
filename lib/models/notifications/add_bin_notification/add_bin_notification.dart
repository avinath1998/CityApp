import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../base_notification.dart';

part 'add_bin_notification.freezed.dart';
part 'add_bin_notification.g.dart';

@freezed
abstract class AddBinNotification extends BaseNotification
    with _$AddBinNotification {
  factory AddBinNotification({
    String title,
    String body,
    String imageSrc,
    String isBinLive,
    NotificationType type,
  }) = _AddBinNotification;

  factory AddBinNotification.fromJson(Map<String, dynamic> json) =>
      _$AddBinNotificationFromJson(json);
}
