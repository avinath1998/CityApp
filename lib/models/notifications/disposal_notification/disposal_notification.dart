import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../bin_disposal.dart';
import '../base_notification.dart';

part 'disposal_notification.freezed.dart';
part 'disposal_notification.g.dart';

@freezed
abstract class DisposalNotification extends BaseNotification
    with _$DisposalNotification {
  factory DisposalNotification({
    String title,
    String body,
    String imageSrc,
    BinDisposalStatus status,
    NotificationType type,
  }) = _DisposalNotification;

  factory DisposalNotification.fromJson(Map<String, dynamic> json) =>
      _$DisposalNotificationFromJson(json);
}
