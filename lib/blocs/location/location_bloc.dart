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
    yield* event.when(started: () {
      logger.info("Started location");
    }, loadLocationEvent: () async* {
      yield LocationState.loadingLocationState();
      await Future.delayed(Duration(seconds: 1));
      if (!await Geolocator().isLocationServiceEnabled()) {
        logger.info("Location services are off");
        yield LocationState.failedLoadingLocationState();
      } else {
        GeolocationStatus status =
            await Geolocator().checkGeolocationPermissionStatus();
        logger.info("Geolocation Status");
        logger.info(status);
        if (status == GeolocationStatus.denied) {
          yield LocationState.locationDeniedState();
        } else if (status == GeolocationStatus.disabled ||
            status == GeolocationStatus.restricted ||
            status == GeolocationStatus.unknown) {
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
      }
    });
  }
}
