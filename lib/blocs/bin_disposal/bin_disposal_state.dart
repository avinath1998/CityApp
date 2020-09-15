part of 'bin_disposal_bloc.dart';

@freezed
abstract class BinDisposalState with _$BinDisposalState {
  const factory BinDisposalState.initial() = _Initial;
  const factory BinDisposalState.binDisposalsLoaded(
      List<BinDisposal> disposals) = _BinDisposalsLoaded;
  const factory BinDisposalState.binDisposalsLoading() = _BinDisposalsLoading;
  const factory BinDisposalState.binDisposalsFailedLoading() =
      _BinDisposalsFailedLoading;

  const factory BinDisposalState.binDisposalFailedSaving(Exception e) =
      _BinDisposalFailedSaving;
  const factory BinDisposalState.binDisposalSaved(BinDisposal disposal) =
      _BinDisposalSaved;
  const factory BinDisposalState.binDisposalSaving() = _BinDisposalSaving;
}
