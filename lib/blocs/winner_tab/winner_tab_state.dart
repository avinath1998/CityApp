part of 'winner_tab_bloc.dart';

abstract class WinnerTabState extends Equatable {
  const WinnerTabState();
}

class WinnerTabInitial extends WinnerTabState {
  @override
  List<Object> get props => [];
}

class UserWonState extends WinnerTabState {
  final ScanWinnings scanWinnings;

  UserWonState(this.scanWinnings);

  @override
  List<Object> get props => [];
}

class UserLostState extends WinnerTabState {
  @override
  List<Object> get props => [];
}

class LoadingWinningsState extends WinnerTabState {
  @override
  List<Object> get props => [];
}

class FailedLoadingWinningsState extends WinnerTabState {
  final String errorMsg;

  FailedLoadingWinningsState(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

class WinningFormSavedState extends WinnerTabState {
  @override
  List<Object> get props => [];
}

class WinningFormFailedState extends WinnerTabState {
  @override
  List<Object> get props => [];
}

class WinningFormLoadingState extends WinnerTabState {
  @override
  List<Object> get props => [];
}
