import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/LocationUpdateException.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'nearby_bins_event.dart';
part 'nearby_bins_state.dart';

class NearbyBinsBloc extends Bloc<NearbyBinsEvent, NearbyBinsState> {
  NearbyBinsBloc(this._dataRepository, this._geolocator);

  final DataRepository _dataRepository;
  final Geolocator _geolocator;
  final Logger logger = Logger("NearbyBinsBloc");

  @override
  NearbyBinsState get initialState => NearbyBinsInitial();

  @override
  Stream<NearbyBinsState> mapEventToState(
    NearbyBinsEvent event,
  ) async* {
    if (event is InitializeCurrentLocationEvent) {
      yield* _loadCurrentLocation();
    } else if (event is OpenBinStreamEvent) {
    } else if (event is CloseBinStreamEvent) {}
  }

  Stream<NearbyBinsState> _loadCurrentLocation() async* {
    try {
      logger.info("Fetching current location...");
      yield CurrentLocationLoadingState();
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      logger.info("Current location fetched.");
      yield CurrentLocationLoadedState(position);
    } on PlatformException catch (e) {
      logger.severe("Failed to fetch current location: ${e.message}");
      yield CurrentLocationFailedState(LocationUpdateException(e.message));
    } catch (e) {
      logger.severe(e.runtimeType);
      logger.severe(e);
    }
  }

  Stream<NearbyBinsState> _openBinStream() async* {
    try {
      logger.info("Open stream bin...");
      yield (OpenPositionStreamState());
      logger.info("Closed stream bin...");
    } catch (e) {
      logger.severe("Closed position stream");
      yield (ClosePositionStreamState());
    }
  }
}
