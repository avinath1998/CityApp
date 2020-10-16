import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'redeem_event.dart';
part 'redeem_state.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  RedeemBloc()
      : super(RedeemInitial(GetIt.instance<DataRepository>().cachedPrizes));

  @override
  Stream<RedeemState> mapEventToState(
    RedeemEvent event,
  ) async* {
    if (event is FetchPrizesEvent) {
      if (GetIt.instance<DataRepository>().cachedPrizes.length == 0) {
        yield RedeemPrizesWaitingState();
      }
      try {
        List<Prize> prizes =
            await GetIt.instance<DataRepository>().fetchPrizes();
        yield RedeemPrizesFetchedState(prizes);
      } catch (e) {
        print(e.toString());
        yield RedeemLoadingFailedState(e);
      }
    }
  }
}
