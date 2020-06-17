import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'cityscan_qrcode.freezed.dart';
part 'cityscan_qrcode.g.dart';

@freezed
abstract class CityScanQrCode with _$CityScanQrCode {
  @JsonSerializable(explicitToJson: true)
  factory CityScanQrCode(
      {@required String type,
      @required String id,
      @required String wasteType,
      @required double locLong,
      @required double locLan}) = _CityScanQrCode;

  factory CityScanQrCode.fromJson(Map<String, dynamic> json) =>
      _$CityScanQrCodeFromJson(json);
}
