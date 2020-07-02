import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_bin_setting.freezed.dart';
part 'live_bin_setting.g.dart';

@freezed
abstract class LiveBinSetting with _$LiveBinSetting {
  @JsonSerializable(explicitToJson: true)
  factory LiveBinSetting(
      {@required String id,
      @required String locationName,
      @required int endTime,
      @required int startTime}) = _LiveBinSetting;

  factory LiveBinSetting.fromJson(Map<String, dynamic> json) =>
      _$LiveBinSettingFromJson(json);
}
