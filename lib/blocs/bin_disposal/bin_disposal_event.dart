part of 'bin_disposal_bloc.dart';

@freezed
abstract class BinDisposalEvent with _$BinDisposalEvent {
  const factory BinDisposalEvent.started() = _Started;
  const factory BinDisposalEvent.fetchAll(CurrentUser user) = _FetchAll;
  const factory BinDisposalEvent.save(
      TaggedBin bin, File wasteImage, File binImage, CurrentUser user) = _Save;
}
