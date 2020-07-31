part of 'bin_validation_bloc.dart';

@immutable
abstract class BinValidationState {}

class BinValidationInitial extends BinValidationState {}

class BinPassedValidation extends BinValidationState {
  final TaggedBin taggedBin;
  BinPassedValidation(this.taggedBin);
}

class BinFailedValidation extends BinValidationState {
  final TaggedBin taggedBin;
  BinFailedValidation(this.taggedBin);
}

class BinLoadingValidation extends BinValidationState {
  BinLoadingValidation();
}
