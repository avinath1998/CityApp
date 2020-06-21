import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/home_tabs/schedule_tab.dart';
import 'package:citycollection/screens/scan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import '../routes/modal_popup_route.dart';
import 'home_tabs/home_tab.dart';
import 'home_tabs/me_tab.dart';
import 'home_tabs/nearby_tab.dart';
import 'home_tabs/redeem_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeTabBloc _homeTabBloc;
  int _currentSelectedBottomNav = 0;
  AnimationController _cardSlideController;
  Animation<double> _radiusAnimation;
  ScrollController _scrollController;
  AnimationController _backController;

  @override
  void initState() {
    _homeTabBloc = HomeTabBloc();
    _cardSlideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _backController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _radiusAnimation = Tween<double>(begin: 0.0, end: 30.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_backController);
    _radiusAnimation.addListener(() {
      setState(() {});
    });
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _backController.dispose();
    _cardSlideController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
            CurvedAnimation(curve: Curves.ease, parent: _backController)),
        child: ClipRRect(
          borderRadius:
              BorderRadius.all(Radius.circular(_radiusAnimation.value)),
          child: Scaffold(
            body: BlocListener<HomeTabBloc, HomeTabState>(
              bloc: _homeTabBloc,
              child: Stack(
                children: <Widget>[
                  NearbyTab(),
                  SlideTransition(
                    position: Tween<Offset>(
                            begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                        .animate(CurvedAnimation(
                            curve: Curves.ease, parent: _cardSlideController)),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.17,
                      initialChildSize: 0.20,
                      builder: (context, scrollController) {
                        return HomeTab(
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                ],
              ),
              listener: (context, state) async {
                if (state is HomeTabTrophiesState) {
                  _cardSlideController.forward();
                } else if (state is HomeTabMeState) {
                  _cardSlideController.reverse();
                  _backController.forward();
                  await showMaterialModalBottomSheet(
                      context: context,
                      expand: false,
                      isDismissible: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      builder: (context, scrollController) {
                        return MeTab(
                          scrollController: scrollController,
                        );
                      });
                  _backController.reverse();
                  setState(() {
                    _currentSelectedBottomNav = 0;
                  });
                  _homeTabBloc.add(SwitchTabEvent(HomeTabs.PersonalHomeTab));
                } else {
                  _cardSlideController.reverse();
                }
              },
            ),
            bottomNavigationBar: TitledBottomNavigationBar(
                currentIndex: _currentSelectedBottomNav,
                onTap: (index) {
                  setState(() {
                    _currentSelectedBottomNav = index;
                  });
                  switch (index) {
                    case 0:
                      _homeTabBloc
                          .add(SwitchTabEvent(HomeTabs.PersonalHomeTab));
                      break;
                    case 1:
                      _homeTabBloc.add(SwitchTabEvent(HomeTabs.AddBinTab));
                      break;
                    case 2:
                      _homeTabBloc.add(SwitchTabEvent(HomeTabs.TrophiesTab));
                      break;
                    case 3:
                      _homeTabBloc.add(SwitchTabEvent(HomeTabs.MeTab));
                      break;
                  }
                },
                activeColor: CityColors.primary_green,
                inactiveColor: Colors.black54,
                items: [
                  TitledNavigationBarItem(title: 'Map', icon: Icons.map),
                  TitledNavigationBarItem(title: 'Add Bin', icon: Icons.add),
                  TitledNavigationBarItem(
                      title: 'Leaderboard', icon: FontAwesomeIcons.trophy),
                  TitledNavigationBarItem(
                      title: 'Me', icon: Icons.account_circle),
                ]),
          ),
        ),
      ),
    );
  }
}
