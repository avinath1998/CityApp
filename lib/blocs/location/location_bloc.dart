import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Logger logger = Logger("LocationBloc");
  LocationBloc() : super(_Initial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    yield* event.when(
        started: () {},
        loadLocationEvent: () async* {
          yield LocationState.loadingLocationState();
          GeolocationStatus status =
              await Geolocator().checkGeolocationPermissionStatus();
          if (status == GeolocationStatus.denied) {
            yield LocationState.failedLoadingLocationState();
          } else if (status == GeolocationStatus.disabled) {
            yield LocationState.locationDisabledState();
          } else {
            try {
              Position position = await Geolocator()
                  .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

              List<Address> addresses = await Geocoder.local
                  .findAddressesFromCoordinates(
                      Coordinates(position.latitude, position.longitude));
              yield LocationState.loadedLocationState(position, addresses);
            } catch (e, stk) {
              logger.severe(stk);
              logger.severe(e);
              yield LocationState.failedLoadingLocationState();
            }
          }
        });
  }
}
