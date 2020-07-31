part of 'bin_scan_steps_bloc.dart';

abstract class BinScanStepsEvent extends Equatable {}

class BinScanStepChangedEvent extends BinScanStepsEvent {
  final int page;
  BinScanStepChangedEvent(this.page);

  @override
  List<Object> get props => [page];
}

class SaveBinEvent extends BinScanStepsEvent {
  final CurrentUser currentUser;
  final String binImage;
  final String wasteImage;
  final ScanWinnings winnings;
  final String phoneNumber;

  SaveBinEvent(this.binImage, this.wasteImage, this.currentUser, this.winnings,
      this.phoneNumber);

  @override
  List<Object> get props =>
      [binImage, wasteImage, currentUser, winnings, phoneNumber];
}
