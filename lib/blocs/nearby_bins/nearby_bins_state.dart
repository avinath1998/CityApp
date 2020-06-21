part of 'nearby_bins_bloc.dart';

@immutable
abstract class NearbyBinsState {}

class NearbyBinsInitial extends NearbyBinsState {}

class CurrentLocationLoadedState extends NearbyBinsState {
  final Position position;
  CurrentLocationLoadedState(this.position);
}

class CurrentLocationLoadingState extends NearbyBinsState {}

class CurrentLocationFailedState extends NearbyBinsState {
  final LocationUpdateException _exception;
  CurrentLocationFailedState(this._exception);
}

class NearbyBinsStreamOpen extends NearbyBinsState {}

class BinsChangedState extends NearbyBinsState {
  final List<TaggedBin> taggedBins;

  BinsChangedState(this.taggedBins);
}

class BinChangeErrorState extends NearbyBinsState {
  final DataFetchException e;

  BinChangeErrorState(this.e);
}
