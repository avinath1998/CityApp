part of 'nearby_bins_bloc.dart';

@immutable
abstract class NearbyBinsEvent {}

class InitializeCurrentLocationEvent extends NearbyBinsEvent {}

class OpenBinStreamEvent extends NearbyBinsEvent {}

class CloseBinStreamEvent extends NearbyBinsEvent {}
