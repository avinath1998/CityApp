import 'package:freezed_annotation/freezed_annotation.dart';

part 'garbage_disposal.freezed.dart';
part 'garbage_disposal.g.dart';

@freezed
abstract class GarbageDisposal with _$GarbageDisposal {
  @JsonSerializable(explicitToJson: true)
  factory GarbageDisposal(
      {@required String id,
      @required String type,
      int count,
      double weight}) = _GarbageDisposal;

  factory GarbageDisposal.fromJson(Map<String, dynamic> json) =>
      _$GarbageDisposalFromJson(json);
}
