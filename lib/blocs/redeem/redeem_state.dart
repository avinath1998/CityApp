part of 'redeem_bloc.dart';

@immutable
abstract class RedeemState {}

class RedeemInitial extends RedeemState {
  final List<Prize> prizes;
  RedeemInitial(this.prizes);
}

class RedeemPrizesWaitingState extends RedeemState {}

class RedeemPrizesFetchedState extends RedeemState {
  final List<Prize> prizes;
  RedeemPrizesFetchedState(this.prizes);
}

class PrizesLoadingSuccessState extends RedeemState {
  final Prize prize;

  PrizesLoadingSuccessState(this.prize);
}

class RedeemLoadingFailedState extends RedeemState {
  final String errorMsg;

  RedeemLoadingFailedState(this.errorMsg);
}
