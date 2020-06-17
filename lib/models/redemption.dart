import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'redemption.freezed.dart';
part 'redemption.g.dart';

@freezed
abstract class Redemption with _$Redemption {
  @JsonSerializable(explicitToJson: true)
  factory Redemption(
      {String id,
      String userId,
      String prizeId,
      String title,
      String desc,
      int cost,
      String redeemTime,
      RedemptionStatus status,
      int indexNumber,
      String declinedReason}) = _Redemption;

  factory Redemption.fromJson(Map<String, dynamic> json) =>
      _$RedemptionFromJson(json);
}

enum RedemptionStatus { awarded, declined, waiting }
