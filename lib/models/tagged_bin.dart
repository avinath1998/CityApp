import 'package:freezed_annotation/freezed_annotation.dart';

part 'tagged_bin.freezed.dart';
part 'tagged_bin.g.dart';

@freezed
abstract class TaggedBin with _$TaggedBin {
  @JsonSerializable(explicitToJson: true)
  factory TaggedBin(
      {String id,
      String binName,
      String imageSrc,
      String userId,
      bool active,
      bool isNew,
      double locationLan,
      double locationLon,
      double taggedTime,
      int pointsEarned,
      int reportStrikes}) = _TaggedBin;

  factory TaggedBin.fromJson(Map<String, dynamic> json) => _$TaggedBin(json);
}
