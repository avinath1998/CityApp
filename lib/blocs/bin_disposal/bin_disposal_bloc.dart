import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/data_upload_exception.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/repositories/bin_disposal_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'bin_disposal_event.dart';
part 'bin_disposal_state.dart';
part 'bin_disposal_bloc.freezed.dart';

class BinDisposalBloc extends Bloc<BinDisposalEvent, BinDisposalState> {
  final Logger logger = Logger("BinDisposalBloc");
  final BinDisposalRepository _binDisposalRepository;

  BinDisposalBloc(this._binDisposalRepository) : super(_Initial());

  @override
  Stream<BinDisposalState> mapEventToState(
    BinDisposalEvent event,
  ) async* {
    yield* event.when(
        started: () {}, fetchAll: _loadAllBinDisposals, save: _saveBinDisposal);
  }

  Stream<BinDisposalState> _loadAllBinDisposals(CurrentUser user) async* {
    logger.info("Loading All Bin Disposals");
  }

  Stream<BinDisposalState> _saveBinDisposal(
      TaggedBin bin, File wasteImage, File binImage, CurrentUser user) async* {
    logger.info("Saving Bin Disposal");
    try {
      yield BinDisposalState.binDisposalSaving();
      BinDisposal disposal = await _binDisposalRepository.saveBinDisposal(
          bin, wasteImage, binImage, user);
      yield BinDisposalState.binDisposalSaved(disposal);
    } on DataUploadException catch (e) {
      yield BinDisposalState.binDisposalFailedSaving(e);
    }
  }
}
