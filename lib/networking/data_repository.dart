import 'dart:async';
import 'dart:typed_data';

import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/DataUploadException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/db.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:logging/logging.dart';

class DataRepository {
  DataRepository(this.db);

  final DB db;
  final List<Prize> cachedPrizes = List();
  final List<TaggedBin> _cachedBins = List();
  StreamController<TaggedBin> _binStreamController;
  StreamSubscription<TaggedBin> _binStreamSubscription;

  final Logger logger = Logger("DataRepository");
  double redeemPageScrollPosition = 0;

  Future<CurrentUser> fetchCurrentUser(String id) {
    try {
      return db.fetchCurrentUser(id);
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }

  Future<PrizeRedemptionStatus> redeemPrize(
      Prize prize, CurrentUser user) async {
    try {
      return await db.redeemPrize(prize, user);
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }

  Future<List<Prize>> fetchPrizes() async {
    try {
      List<Prize> prizes = await db.fetchPrizes();
      prizes.forEach((prize) {
        if (!cachedPrizes.contains(prize)) {
          cachedPrizes.add(prize);
        }
      });
      return prizes;
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }

  List<TaggedBin> openBinStream(Function(List<TaggedBin> bins) onBinsChanged) {
    try {
      logger.info("Opening bin stream");
      _binStreamController = db.openBinStream();
      _binStreamSubscription =
          _binStreamController.stream.listen((TaggedBin bin) {
        if (_cachedBins.contains(bin)) {
          logger.info("Bin: ${bin.id} already exists in cache");
        } else {
          bool contained = false;
          _cachedBins.forEach((oldBin) {
            if (oldBin.id == bin.id) {
              _cachedBins.remove(oldBin);
              _cachedBins.add(bin);
              contained = true;
            }
          });
          if (!contained) _cachedBins.add(bin);
        }
        logger.info("Bin Cache: ${_cachedBins.length}");
        onBinsChanged(_cachedBins);
      });
      return _cachedBins;
    } catch (e, stacktrace) {
      logger.severe("Opening bin stream has failed: ${e.toString()}");
      logger.severe(stacktrace);
      throw DataFetchException(e.toString());
    }
  }

  void closeBinStream() {
    logger.info("Closing bin streamcontrollers and subscriptions");
    db.closeBinStream();
    _binStreamController?.close();
    _binStreamSubscription?.cancel();
  }

  Future<String> uploadWasteImage(CurrentUser user, Uint8List image) async {
    try {
      String ref = await db.uploadWasteImageData(user, image);
      return ref;
    } catch (e, stacktrace) {
      logger.severe("Error uploading disposal data");
      logger.severe(stacktrace);
      throw DataUploadException(e, stacktrace);
    }
  }

  Future<String> saveDisposalData(
      CurrentUser user,
      String binImageRef,
      String wasteItemRef,
      ScanWinnings scanWinnings,
      String phoneNumber) async {
    return db.saveDisposalData(
        user, binImageRef, wasteItemRef, scanWinnings, phoneNumber);
  }

  Future<String> uploadBinImage(CurrentUser user, Uint8List image) async {
    try {
      String ref = await db.uploadBinImageData(user, image);
      return ref;
    } catch (e, stacktrace) {
      logger.severe("Error uploading disposal data");
      logger.severe(stacktrace);
      throw DataUploadException(e, stacktrace);
    }
  }

  Future<ScanWinnings> fetchScanWinnings(CurrentUser user) async {
    return db.fetchScanWinnings(user);
  }
}
