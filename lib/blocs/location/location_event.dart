part of 'location_bloc.dart';

@freezed
abstract class LocationEvent with _$LocationEvent {
  const factory LocationEvent.started() = _Started;
  const factory LocationEvent.loadLocationEvent() = _LoadLocationEvent;

}