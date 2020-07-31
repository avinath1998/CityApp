import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/DataUploadException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'bin_scan_steps_event.dart';
part 'bin_scan_steps_state.dart';

class BinScanStepsBloc extends Bloc<BinScanStepsEvent, BinScanStepsState> {
  final Logger logger = Logger("BinScanStepsBloc");
  final DataRepository _dataRepository;

  BinScanStepsBloc(this._dataRepository);

  @override
  BinScanStepsState get initialState => BinScanStepsInitial();

  @override
  Stream<BinScanStepsState> mapEventToState(
    BinScanStepsEvent event,
  ) async* {
    if (event is BinScanStepChangedEvent) {
      logger.info("Scanning bin changed.");
      yield BinScanStepChangedState(event.page, "sd");
    } else if (event is SaveBinEvent) {
      logger.info("Saving Bin Event");
      yield* _saveDisposalData(event.currentUser, event.binImage,
          event.wasteImage, event.winnings, event.phoneNumber);
    }
  }

  Stream<BinScanStepsState> _saveDisposalData(
      CurrentUser currentUser,
      String binImage,
      String wasteImage,
      ScanWinnings scanWinnings,
      String phoneNumber) async* {
    try {
      if (scanWinnings != null) {
        yield DisposalDataLoadingState();
      }
      await _dataRepository.saveDisposalData(
          currentUser, binImage, wasteImage, scanWinnings, phoneNumber);
      if (scanWinnings != null) {
        yield DisposalDataSavedState(scanWinnings != null);
      }
    } on DataUploadException catch (e) {
      logger.severe(e.errorMsg);
      logger.severe(e.stackTrace);
      yield DisposalDataFailedState(e.errorMsg);
    }
  }
}
