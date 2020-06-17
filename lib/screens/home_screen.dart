import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/home_tabs/schedule_tab.dart';
import 'package:citycollection/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'home_tabs/home_tab.dart';
import 'home_tabs/me_tab.dart';
import 'home_tabs/nearby_tab.dart';
import 'home_tabs/redeem_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeTabBloc _homeTabBloc;
  @override
  void initState() {
    _homeTabBloc = HomeTabBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeTabBloc, HomeTabState>(
        bloc: _homeTabBloc,
        builder: (context, HomeTabState state) {
          if (state is HomeTabHomeState) {
            return HomeTab();
          } else if (state is HomeTabRedeemState) {
            return RedeemTab();
          } else if (state is HomeTabScheduleState) {
            return ScheduleTab();
          } else if (state is HomeTabNearbyState) {
            return NearbyTab();
          } else if (state is HomeTabMeState) {
            return MeTab();
          } else if (state is HomeTabInitial) {
            return HomeTab();
          } else {
            return HomeTab();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ScanScreen()));
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.camera, color: Colors.white),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                _homeTabBloc.add(SwitchTabEvent(HomeTabs.PersonalHomeTab));
                break;
              case 1:
                _homeTabBloc.add(SwitchTabEvent(HomeTabs.RedeemTab));
                break;
              case 2:
                _homeTabBloc.add(SwitchTabEvent(HomeTabs.ScheduleTab));
                break;
              case 3:
                _homeTabBloc.add(SwitchTabEvent(HomeTabs.NearbyTab));
                break;
              case 4:
                _homeTabBloc.add(SwitchTabEvent(HomeTabs.MeTab));
                break;
            }
          },
          activeColor: CityColors.primary_green,
          inactiveColor: Colors.black54,
          items: [
            TitledNavigationBarItem(
              title: 'Home',
              icon: Icons.home,
            ),
            TitledNavigationBarItem(title: 'Redeem', icon: Icons.card_giftcard),
            TitledNavigationBarItem(title: 'Schedule', icon: Icons.timer),
            TitledNavigationBarItem(title: 'Nearby', icon: Icons.map),
            TitledNavigationBarItem(title: 'Me', icon: Icons.account_circle),
          ]),
    );
  }
}
