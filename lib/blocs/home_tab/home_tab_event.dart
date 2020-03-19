part of 'home_tab_bloc.dart';

@immutable
abstract class HomeTabEvent {}

class SwitchTabEvent extends HomeTabEvent {
  final HomeTabs homeTab;

  SwitchTabEvent(this.homeTab);
}
