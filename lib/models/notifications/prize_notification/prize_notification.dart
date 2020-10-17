import 'package:citycollection/models/prize.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../base_notification.dart';

part 'prize_notification.freezed.dart';
part 'prize_notification.g.dart';

@freezed
abstract class PrizeNotification extends BaseNotification
    with _$PrizeNotification {
  factory PrizeNotification({
    String title,
    String body,
    String imageSrc,
    PrizeRedemptionStatus status,
    NotificationType type,
  }) = _PrizeNotification;

  factory PrizeNotification.fromJson(Map<String, dynamic> json) =>
      _$PrizeNotificationFromJson(json);
}
