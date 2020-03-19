import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/home_tabs/schedule_tab.dart';
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
      appBar: AppBar(
        title: BlocBuilder(
            bloc: _homeTabBloc,
            builder: (context, HomeTabState state) {
              if (state is HomeTabHomeState) {
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Home",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0))
                  ]),
                );
              } else if (state is HomeTabRedeemState) {
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Redeem",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0)),
                    TextSpan(
                        text: "Prizes",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 20.0))
                  ]),
                );
              } else if (state is HomeTabScheduleState) {
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Schedule",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0)),
                    TextSpan(
                        text: "Pickup",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 20.0))
                  ]),
                );
              } else if (state is HomeTabNearbyState) {
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Validation",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0)),
                    TextSpan(
                        text: "Management",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 20.0))
                  ]),
                );
              } else if (state is HomeTabMeState) {
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Me",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0)),
                  ]),
                );
              } else if (state is HomeTabInitial) {
                return RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Home",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.0)),
                  ]),
                );
              }
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
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
          }
        },
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
            TitledNavigationBarItem(title: 'Home', icon: Icons.home),
            TitledNavigationBarItem(title: 'Redeem', icon: Icons.card_giftcard),
            TitledNavigationBarItem(title: 'Schedule', icon: Icons.timer),
            TitledNavigationBarItem(title: 'Nearby', icon: Icons.map),
            TitledNavigationBarItem(title: 'Me', icon: Icons.account_circle),
          ]),
    );
  }
}
