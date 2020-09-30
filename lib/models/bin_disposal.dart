import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'bin_disposal.freezed.dart';
part 'bin_disposal.g.dart';

@freezed
abstract class BinDisposal with _$BinDisposal {
  @JsonSerializable(explicitToJson: true)
  factory BinDisposal(
      {@required String binId,
      @required String userId,
      @required String binName,
      @required String wasteImageSrc,
      @required String binImageSrc,
      @required DateTime disposalTime,
      String message,
      int pointAmount,
      @required BinDisposalStatus status}) = _BinDisposal;

  factory BinDisposal.fromJson(Map<String, dynamic> json) =>
      _$BinDisposalFromJson(json);
}

enum BinDisposalStatus { pending, approved, disapproved }
