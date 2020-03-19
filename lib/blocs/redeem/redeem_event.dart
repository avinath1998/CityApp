part of 'redeem_bloc.dart';

@immutable
abstract class RedeemEvent {}

class FetchPrizesEvent extends RedeemEvent {}

class RedeemPrizeEvent extends RedeemEvent {
  final Prize prize;
  final CurrentUser user;
  RedeemPrizeEvent(this.prize, this.user);
}
