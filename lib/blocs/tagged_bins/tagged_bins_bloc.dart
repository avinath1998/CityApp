import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/data_upload_exception.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

part 'tagged_bins_event.dart';
part 'tagged_bins_state.dart';

class TaggedBinsBloc extends Bloc<TaggedBinsEvent, TaggedBinsState> {
  final Logger logger = Logger("TaggedBinsBloc");

  final DataRepository _dataRepository;

  TaggedBinsBloc(this._dataRepository) : super(TaggedBinsInitial());

  @override
  Stream<TaggedBinsState> mapEventToState(
    TaggedBinsEvent event,
  ) async* {
    if (event is UploadTaggedBinEvent) {
      yield* _uploadTaggedBin(event.user, event.bin, event.image);
    } else if (event is EditTaggedBinEvent) {
      yield* _editTaggedBin(event.user, event.bin);
    }
  }

  Stream<TaggedBinsState> _uploadTaggedBin(
      CurrentUser user, TaggedBin bin, File image) async* {
    logger.info("Uploading tagged bin");
    try {
      yield UploadingTaggedBinState();
      await _dataRepository.uploadTaggedBin(user, bin, image);
      yield UploadSucessTaggedBinState(bin);
    } on DataUploadException catch (e) {
      yield UploadFailedTaggedBinState(e, e.errorMsg);
    }
  }

  Stream<TaggedBinsState> _editTaggedBin(
      CurrentUser user, TaggedBin bin) async* {
    logger.info("Uploading tagged bin");
    try {
      yield UploadingTaggedBinState();
      await _dataRepository.updateTaggedBin(user, bin);
      yield UploadSucessTaggedBinState(bin);
    } on DataUploadException catch (e) {
      yield UploadFailedTaggedBinState(e, e.errorMsg);
    }
  }
}
