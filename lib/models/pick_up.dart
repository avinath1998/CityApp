import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:citycollection/models/garbage_disposal.dart';

part 'pick_up.freezed.dart';
part 'pick_up.g.dart';

@freezed
abstract class Pickup with _$Pickup {
  @JsonSerializable(explicitToJson: true)
  factory Pickup({
    @required String id,
    @required String userId,
    @required String collectionTripId,
    @required String status,
    int pointsAwarded,
    @required List<GarbageDisposal> garbageDisposals,
  }) = _Pickup;

  factory Pickup.fromJson(Map<String, dynamic> json) => _$PickupFromJson(json);
}

enum PickupStatus {
  waiting,
  pickedUp,
  validated,
  cancelledByUser,
  cancelledByDriver,
  declinedByManagement,
  confirmed
}
