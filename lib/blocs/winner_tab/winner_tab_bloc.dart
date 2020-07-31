import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/DataUploadException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

part 'winner_tab_event.dart';
part 'winner_tab_state.dart';

class WinnerTabBloc extends Bloc<WinnerTabEvent, WinnerTabState> {
  final Logger logger = Logger("WinnerTabBloc");
  final DataRepository _dataRepository;
  final CurrentUser _currentUser;
  WinnerTabBloc(this._dataRepository, this._currentUser);

  @override
  Stream<WinnerTabState> mapEventToState(
    WinnerTabEvent event,
  ) async* {
    if (event is FetchWinningsEvent) {
      yield* _fetchWinnings();
    }
  }

  Stream<WinnerTabState> _fetchWinnings() async* {
    logger.info("Checking Winnings");
    try {
      yield (LoadingWinningsState());
      ScanWinnings winnings =
          await _dataRepository.fetchScanWinnings(_currentUser);
      if (winnings == null) {
        logger.info("No winnings fetched.");
        yield (UserLostState());
      } else {
        logger.info("Winner winner chicken dinner!!");
        logger.info("Winnings ID: ${winnings.id}, amount ${winnings.winnings}");
        yield (UserWonState(winnings));
      }
    } on DataFetchException catch (e) {
      yield (FailedLoadingWinningsState(e.toString()));
    }
  }

  @override
  WinnerTabState get initialState => WinnerTabInitial();
}
