import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/prize_redemption_status.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'redeem_prize_event.dart';
part 'redeem_prize_state.dart';

class RedeemPrizeBloc extends Bloc<RedeemPrizeEvent, RedeemPrizeState> {
  final String TAG = "REDEEMPRIZEBLOC: ";
  @override
  RedeemPrizeState get initialState => RedeemPrizeInitial();

  @override
  Stream<RedeemPrizeState> mapEventToState(
    RedeemPrizeEvent event,
  ) async* {
    if (event is RedeemCityPrizeEvent) {
      yield* redeemPrize(event.prize, event.user);
    }
  }

  Stream<RedeemPrizeState> redeemPrize(Prize prize, CurrentUser user) async* {
    try {
      print(TAG + " Redeeming Prize ${prize.id}");
      yield PrizeRedeemedWaitingState();
      PrizeRedemptionStatus redemptionStatus =
          await GetIt.instance<DataRepository>().redeemPrize(prize, user);
      if (redemptionStatus == PrizeRedemptionStatus.WAITING) {
        yield PrizeRedeemedSuccessState(prize);
      } else if (redemptionStatus == PrizeRedemptionStatus.NOT_ENOUGH_POINTS) {
        yield PrizeRedeemedFailedState("Not enough points on your account.");
      }
    } on DataFetchException catch (e) {
      print(TAG + " Failed to redeem prize ${prize.id}");
      yield PrizeRedeemedFailedState(e.toString());
    }
  }
}
