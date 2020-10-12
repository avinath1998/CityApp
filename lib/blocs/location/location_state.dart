part of 'location_bloc.dart';

@freezed
abstract class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loadingLocationState() = _LoadingLocationState;
  const factory LocationState.loadedLocationState(
          final Position position, final List<Address> addressname) =
      _LoadedLocationState;
  const factory LocationState.failedLoadingLocationState() =
      _FailedLoaingLocationState;
  const factory LocationState.locationDisabledState() = _LocationDisabledState;
  const factory LocationState.locationDeniedState() = _LocationDeniedState;
  const factory LocationState.locationServicesOffState() =
      _LocationServicesOffState;
}
