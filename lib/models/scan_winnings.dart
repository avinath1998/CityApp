import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_winnings.freezed.dart';
part 'scan_winnings.g.dart';

@freezed
abstract class ScanWinnings with _$ScanWinnings {
  @JsonSerializable(explicitToJson: true)
  factory ScanWinnings(
      {String id,
      String claimedByUserId,
      bool isActive,
      double winnings}) = _ScanWinnings;

  factory ScanWinnings.fromJson(Map<String, dynamic> json) =>
      _$ScanWinningsFromJson(json);
}
