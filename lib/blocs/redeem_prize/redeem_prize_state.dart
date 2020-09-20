part of 'redeem_prize_bloc.dart';

@immutable
abstract class RedeemPrizeState {}

class RedeemPrizeInitial extends RedeemPrizeState {}

class PrizeRedeemedSuccessState extends RedeemPrizeState {
  final Prize prize;

  PrizeRedeemedSuccessState(this.prize);
}

class PrizeRedeemedFailedState extends RedeemPrizeState {
  final PrizeRedemptionStatus status;
  PrizeRedeemedFailedState(this.status);
}

class PrizeRedeemedWaitingState extends RedeemPrizeState {}
