import 'package:freezed_annotation/freezed_annotation.dart';

part 'prize.freezed.dart';
part 'prize.g.dart';

@freezed
abstract class Prize with _$Prize {
  @JsonSerializable(explicitToJson: true)
  factory Prize(
      {String desc,
      String image,
      int remaining,
      DateTime expirationDate,
      String name,
      String id,
      int cost,
      PrizeRedemptionStatus status,
      String type}) = _Prize;

  factory Prize.fromJson(Map<String, dynamic> json) => _$PrizeFromJson(json);
}

enum PrizeRedemptionStatus {
  delivered,
  notEnoughPoints,
  couponCodesFinished,
  disallowed,
  waiting
}
