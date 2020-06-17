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

class OpenPositionStreamState extends NearbyBinsState {
  final StreamController _binStreamController;
  OpenPositionStreamState(this._binStreamController);
}

class ClosePositionStreamState extends NearbyBinsState {
  final StreamController _binStreamController;
  ClosePositionStreamState(this._binStreamController);
}
