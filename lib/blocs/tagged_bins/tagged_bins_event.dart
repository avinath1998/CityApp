part of 'tagged_bins_bloc.dart';

abstract class TaggedBinsEvent extends Equatable {
  const TaggedBinsEvent();

  @override
  List<Object> get props => [];
}

class FetchTaggedBinsEvent extends TaggedBinsEvent {
  final CurrentUser user;

  FetchTaggedBinsEvent(this.user);
}

class EditTaggedBinEvent extends TaggedBinsEvent {
  final CurrentUser user;
  final TaggedBin bin;
  EditTaggedBinEvent(this.user, this.bin);
}

class UploadTaggedBinEvent extends TaggedBinsEvent {
  final CurrentUser user;
  final TaggedBin bin;
  final File image;
  UploadTaggedBinEvent(this.bin, this.image, this.user);
}
