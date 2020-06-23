part of 'nearby_bins_bloc.dart';

@immutable
abstract class NearbyBinsEvent {}

class InitializeCurrentLocationEvent extends NearbyBinsEvent {}

class OpenBinStreamEvent extends NearbyBinsEvent {}

class CloseBinStreamEvent extends NearbyBinsEvent {}

class BinChangedEvent extends NearbyBinsEvent {
  final List<TaggedBin> _taggedBins;
  BinChangedEvent(this._taggedBins);
}

class SelectBinEvent extends NearbyBinsEvent {
  final TaggedBin _selectedTaggedBin;
  SelectBinEvent(this._selectedTaggedBin);
}
