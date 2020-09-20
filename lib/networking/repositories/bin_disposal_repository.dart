import 'dart:io';

import 'package:citycollection/exceptions/data_upload_exception.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/networking/repositories/base_repository.dart';

class BinDisposalRepository extends BaseRepository {
  BinDisposalRepository(this.db);
  final DB db;

  Future<BinDisposal> saveBinDisposal(
      TaggedBin bin, File wasteImage, File binImage, CurrentUser user) async {
    try {
      return await db.saveBinDisposal(bin, wasteImage, binImage, user);
    } catch (e, stk) {
      throw DataUploadException(e.toString(), stk);
    }
  }
}
