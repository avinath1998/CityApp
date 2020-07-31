part of 'winner_tab_bloc.dart';

abstract class WinnerTabEvent extends Equatable {
  const WinnerTabEvent();
}

class FetchWinningsEvent extends WinnerTabEvent {
  @override
  List<Object> get props => [];
}
