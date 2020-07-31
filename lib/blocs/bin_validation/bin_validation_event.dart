part of 'bin_validation_bloc.dart';

@immutable
abstract class BinValidationEvent {}

class CheckBinValidityEvent extends BinValidationEvent {
  final TaggedBin taggedBin;
  CheckBinValidityEvent(this.taggedBin);
}
