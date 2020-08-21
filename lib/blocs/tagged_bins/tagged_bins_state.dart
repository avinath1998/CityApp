part of 'tagged_bins_bloc.dart';

abstract class TaggedBinsState extends Equatable {
  const TaggedBinsState();

  @override
  List<Object> get props => [];
}

class TaggedBinsInitial extends TaggedBinsState {}

class FetchedTaggedBinsState extends TaggedBinsState {
  final List<TaggedBin> bins;

  FetchedTaggedBinsState(this.bins);
}

class FailedFetchingTaggedBinsState extends TaggedBinsState {
  final Exception e;
  final String errorMsg;

  FailedFetchingTaggedBinsState(this.e, this.errorMsg);
}

class UploadSucessTaggedBinState extends TaggedBinsState {
  final TaggedBin bin;

  UploadSucessTaggedBinState(this.bin);
}

class UploadFailedTaggedBinState extends TaggedBinsState {
  final Exception e;
  final String errorMsg;

  UploadFailedTaggedBinState(this.e, this.errorMsg);
}

class UploadingTaggedBinState extends TaggedBinsState {}
