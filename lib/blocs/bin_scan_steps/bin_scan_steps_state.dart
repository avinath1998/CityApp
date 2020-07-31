part of 'bin_scan_steps_bloc.dart';

abstract class BinScanStepsState extends Equatable {
  const BinScanStepsState();
}

class BinScanStepsInitial extends BinScanStepsState {
  @override
  List<Object> get props => [];
}

class BinScanStepChangedState extends BinScanStepsState {
  final int page;
  final String voild;
  BinScanStepChangedState(this.page, this.voild);

  @override
  List<Object> get props => [page];
}

class DisposalDataSavedState extends BinScanStepsState {
  final bool wonPrize;

  DisposalDataSavedState(this.wonPrize);
  @override
  // TODO: implement props
  List<Object> get props => [wonPrize];
}

class DisposalDataLoadingState extends BinScanStepsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DisposalDataFailedState extends BinScanStepsState {
  final String errorMsg;

  DisposalDataFailedState(this.errorMsg);
  @override
  // TODO: implement props
  List<Object> get props => [errorMsg];
}
