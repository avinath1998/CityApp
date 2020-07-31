import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'bin_validation_event.dart';
part 'bin_validation_state.dart';

class BinValidationBloc extends Bloc<BinValidationEvent, BinValidationState> {
  final Logger logger = Logger("BinValidationBloc");
  @override
  BinValidationState get initialState => BinValidationInitial();

  @override
  Stream<BinValidationState> mapEventToState(
    BinValidationEvent event,
  ) async* {
    if (event is CheckBinValidityEvent) {
      yield* _checkBinValidity(event.taggedBin);
    }
  }

  Stream<BinValidationState> _checkBinValidity(TaggedBin bin) async* {
    yield (BinPassedValidation(bin));
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    double distance = await Geolocator().distanceBetween(position.latitude,
        position.longitude, bin.locationLan, bin.locationLon);
    logger.info(distance);
    if (distance < 5) {
      logger.info("Distance is less than 5 meters, test passed");
      yield (BinPassedValidation(bin));
    } else {
      logger.info("Distance is more than 5 meters, test failed");
      yield (BinFailedValidation(bin));
    }
  }
}
