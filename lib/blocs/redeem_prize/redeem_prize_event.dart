part of 'redeem_prize_bloc.dart';

@immutable
abstract class RedeemPrizeEvent {}

class RedeemCityPrizeEvent extends RedeemPrizeEvent {
  final Prize prize;
  final CurrentUser user;

  RedeemCityPrizeEvent(this.prize, this.user);
}
