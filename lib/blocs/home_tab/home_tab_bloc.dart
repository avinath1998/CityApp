import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:meta/meta.dart';

import 'home_tabs.dart';

part 'home_tab_event.dart';
part 'home_tab_state.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  HomeTabBloc() : super(HomeTabInitial());

  @override
  Stream<HomeTabState> mapEventToState(
    HomeTabEvent event,
  ) async* {
    if (event is SwitchTabEvent) {
      switch (event.homeTab) {
        case HomeTabs.NearbyTab:
          yield (HomeTabNearbyState());
          break;
        case HomeTabs.AddBinTab:
          yield (HomeTabAddBinState());
          break;
        case HomeTabs.TrophiesTab:
          yield (HomeTabTrophiesState());
          break;
        case HomeTabs.RedeemTab:
          yield (HomeTabRedeemState());
          break;
        case HomeTabs.MeTab:
          yield (HomeTabMeState());
          break;
      }
    }
  }
}
