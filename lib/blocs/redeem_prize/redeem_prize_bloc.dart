import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/blocs/redeem/redeem_bloc.dart';
import 'package:citycollection/exceptions/data_fetch_exception.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/redemption.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'redeem_prize_event.dart';
part 'redeem_prize_state.dart';

class RedeemPrizeBloc extends Bloc<RedeemPrizeEvent, RedeemPrizeState> {
  final String TAG = "REDEEMPRIZEBLOC: ";

  RedeemPrizeBloc() : super(RedeemPrizeInitial());

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
      if (redemptionStatus == PrizeRedemptionStatus.waiting) {
        yield PrizeRedeemedSuccessState(prize);
      } else {
        yield PrizeRedeemedFailedState(redemptionStatus);
      }
    } on DataFetchException catch (e) {
      print(TAG + " Failed to redeem prize ${prize.id}" + " " + e.toString());
      yield PrizeRedeemedFailedState(PrizeRedemptionStatus
          .disallowed); //lol we gotta change this, if the prize fails to redeem, its disallowed??
    }
  }
}
