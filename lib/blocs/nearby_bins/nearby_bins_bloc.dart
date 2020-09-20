import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/data_fetch_exception.dart';
import 'package:citycollection/exceptions/location_update_exception.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'nearby_bins_event.dart';
part 'nearby_bins_state.dart';

class NearbyBinsBloc extends Bloc<NearbyBinsEvent, NearbyBinsState> {
  NearbyBinsBloc(this._dataRepository, this._geolocator)
      : super(NearbyBinsInitial());

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
      yield* _openBinsStream();
    } else if (event is BinChangedEvent) {
      yield BinsChangedState(event._taggedBins);
    } else if (event is SelectBinEvent) {
      logger.info(event._selectedTaggedBin);
      yield* _loadSelectedBin(event._selectedTaggedBin);
    }
  }

  Stream<NearbyBinsState> _loadSelectedBin(TaggedBin selectedBinEvent) async* {
    yield SelectedBinState(selectedBinEvent);
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

  Stream<NearbyBinsState> _openBinsStream() async* {
    try {
      logger.info("Open stream bin...");
      List<TaggedBin> _initialTaggedBins =
          _dataRepository.openBinStream((List<TaggedBin> _newBins) {
        add(BinChangedEvent(_newBins));
      });
      yield BinsChangedState(_initialTaggedBins);
    } on DataFetchException catch (e, stacktrace) {
      logger.severe("Error opening bin stream: ${e.toString()}");
      logger.severe(stacktrace);
      yield (BinChangeErrorState(e));
    }
  }

  @override
  Future<void> close() {
    _dataRepository.closeBinStream();
    return super.close();
  }
}
