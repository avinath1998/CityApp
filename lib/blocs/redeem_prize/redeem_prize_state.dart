part of 'redeem_prize_bloc.dart';

@immutable
abstract class RedeemPrizeState {}

class RedeemPrizeInitial extends RedeemPrizeState {}

class PrizeRedeemedSuccessState extends RedeemPrizeState {
  final Prize prize;

  PrizeRedeemedSuccessState(this.prize);
}

class PrizeRedeemedFailedState extends RedeemPrizeState {
  final String errorMsg;

  PrizeRedeemedFailedState(this.errorMsg);
}

class PrizeRedeemedWaitingState extends RedeemPrizeState {}
