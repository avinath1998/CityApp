import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/bin_disposal/bin_disposal_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/blocs/nearby_bins/nearby_bins_bloc.dart';
import 'package:citycollection/blocs/tagged_bins/tagged_bins_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/live_bin_setting.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:citycollection/networking/repositories/bin_disposal_repository.dart';
import 'package:citycollection/screens/add_bin/add_bin_widget.dart';
import 'package:citycollection/screens/me/home_tab.dart';
import 'package:citycollection/screens/general/take_picture_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import '../routes/modal_popup_route.dart';
import 'got_trash/got_trash_screen.dart';
import 'leaderboard/leaderboard_tab.dart';
import 'map/nearby_widget.dart';
import 'rewards/rewards_widget.dart';
import 'dart:math';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/extensions/date_time_extension.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final Logger logger = Logger("HomeScreenState");
  HomeTabBloc _homeTabBloc;
  NearbyBinsBloc _nearbyBinsBloc;
  int _currentSelectedBottomNav = 0;
  AnimationController _cardSlideController;
  AnimationController _rewardsCardSlideController;
  AnimationController _leaderboardCardSlideController;
  AnimationController _pointsCardController;
  AnimationController _backController;
  AnimationController _mapClosestBinController;
  Animation<double> _radiusAnimation;
  ScrollController _scrollController;
  TaggedBin _currentSelectedBin;

  @override
  void initState() {
    super.initState();
    _homeTabBloc = HomeTabBloc();

    _nearbyBinsBloc =
        NearbyBinsBloc(GetIt.instance<DataRepository>(), Geolocator());
    _rewardsCardSlideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _leaderboardCardSlideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _cardSlideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _backController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _pointsCardController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _mapClosestBinController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _radiusAnimation = Tween<double>(begin: 0.0, end: 30.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_backController);
    _radiusAnimation.addListener(() {
      setState(() {});
    });
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nearbyBinsBloc.add(InitializeCurrentLocationEvent());
      _nearbyBinsBloc.add(OpenBinStreamEvent());
      _pointsCardController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _backController.dispose();
    _cardSlideController.dispose();
    _leaderboardCardSlideController.dispose();
    _nearbyBinsBloc.close();
    _rewardsCardSlideController.dispose();
    _pointsCardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _nearbyBinsBloc,
          ),
          BlocProvider(
            create: (context) => _homeTabBloc,
          ),
        ],
        child: SafeArea(
          child: Scaffold(body: _buildNormalHome()),
        ),
      ),
    );
  }

  Widget _buildNormalHome() {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(curve: Curves.ease, parent: _backController)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_radiusAnimation.value)),
        child: Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener(
                cubit: _homeTabBloc,
                listener: (context, state) async {
                  if (state is HomeTabNearbyState) {
                    _cardSlideController.reverse();
                    _backController.reverse();
                    _rewardsCardSlideController.reverse();
                    _leaderboardCardSlideController.reverse();
                    _pointsCardController.forward();
                  } else if (state is HomeTabAddBinState) {
                    _cardSlideController.reverse();
                    _rewardsCardSlideController.reverse();
                    _mapClosestBinController.reverse();
                    _leaderboardCardSlideController.reverse();
                    _pointsCardController.reverse();
                    _backController.forward();
                    await showMaterialModalBottomSheet(
                        context: context,
                        expand: false,
                        isDismissible: true,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (context, scrollController) {
                          return TakePictureTab(
                            scrollController: scrollController,
                          );
                        });
                    _backController.reverse();
                    setState(() {
                      _currentSelectedBottomNav = 0;
                    });
                    _pointsCardController.forward();
                  } else if (state is HomeTabMeState) {
                    _mapClosestBinController.reverse();
                    _leaderboardCardSlideController.reverse();

                    _cardSlideController.forward();
                    _pointsCardController.reverse();
                    _rewardsCardSlideController.reverse();
                  } else if (state is HomeTabTrophiesState) {
                    _mapClosestBinController.reverse();
                    _cardSlideController.reverse();
                    _pointsCardController.reverse();
                    _leaderboardCardSlideController.forward();
                    _rewardsCardSlideController.reverse();
                  } else if (state is HomeTabRedeemState) {
                    _mapClosestBinController.reverse();
                    _cardSlideController.reverse();
                    _pointsCardController.reverse();
                    _leaderboardCardSlideController.reverse();
                    _rewardsCardSlideController.forward();
                  } else {
                    _cardSlideController.reverse();
                    _pointsCardController.forward();
                    _leaderboardCardSlideController.reverse();
                  }
                },
              ),
              BlocListener(
                cubit: _nearbyBinsBloc,
                listener: (context, state) async {
                  if (state is SelectedBinState) {
                    _mapClosestBinController.reverse();
                    _cardSlideController.reverse();
                    _backController.reverse();
                    _rewardsCardSlideController.reverse();
                    _pointsCardController.forward();
                    _leaderboardCardSlideController.reverse();
                    setState(() {
                      _currentSelectedBottomNav = 0;
                      _currentSelectedBin = state.bin;
                    });
                    _mapClosestBinController.forward();
                  }
                },
              )
            ],
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                NearbyTab(),
                Align(
                  alignment: Alignment.topCenter,
                  child: SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              curve: Curves.ease,
                              parent: _pointsCardController)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<AuthBloc, AuthState>(
                                  buildWhen: (oldState, newState) {
                                    return newState is SignedInState;
                                  },
                                  builder: (context, state) {
                                    if (state is SignedInState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Hi, ${state.user.name.split(" ").first}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text("Your Ekva Balance: ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1),
                                              Text(
                                                "${state.user.points} points.",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text(
                                        "Hi,",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      );
                                    }
                                  },
                                ),
                              ],
                            )),
                      )),
                ),
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
                SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          curve: Curves.ease,
                          parent: _rewardsCardSlideController)),
                  child: DraggableScrollableSheet(
                    minChildSize: 0.17,
                    initialChildSize: 0.20,
                    builder: (context, scrollController) {
                      return RedeemTab(
                        scrollController: scrollController,
                      );
                    },
                  ),
                ),
                SlideTransition(
                  position: Tween<Offset>(
                          begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          curve: Curves.ease,
                          parent: _leaderboardCardSlideController)),
                  child: DraggableScrollableSheet(
                    minChildSize: 0.17,
                    initialChildSize: 0.20,
                    builder: (context, scrollController) {
                      return LeaderboardTab(
                        scrollController: scrollController,
                      );
                    },
                  ),
                ),
                Container(
                    child: _buildBinCard(), alignment: Alignment.bottomCenter)
              ],
            ),
          ),
          bottomNavigationBar: TitledBottomNavigationBar(
              currentIndex: _currentSelectedBottomNav,
              onTap: (index) {
                setState(() {
                  _currentSelectedBottomNav = index;
                });
                switch (index) {
                  case 0:
                    _homeTabBloc.add(SwitchTabEvent(HomeTabs.NearbyTab));
                    break;
                  case 1:
                    _homeTabBloc.add(SwitchTabEvent(HomeTabs.RedeemTab));
                    break;
                  case 2:
                    _homeTabBloc.add(SwitchTabEvent(HomeTabs.AddBinTab));
                    break;
                  case 3:
                    _homeTabBloc.add(SwitchTabEvent(HomeTabs.TrophiesTab));
                    break;
                  case 4:
                    _homeTabBloc.add(SwitchTabEvent(HomeTabs.MeTab));
                    break;
                }
              },
              activeColor: CityColors.primary_teal,
              inactiveColor: Colors.black54,
              items: [
                TitledNavigationBarItem(title: 'Map', icon: Icons.map),
                TitledNavigationBarItem(
                    title: 'Rewards', icon: Icons.card_giftcard),
                TitledNavigationBarItem(title: 'Add Bin', icon: Icons.add),
                TitledNavigationBarItem(
                    title: 'Champs', icon: Icons.insert_chart),
                TitledNavigationBarItem(
                    title: 'Me', icon: Icons.account_circle),
              ]),
        ),
      ),
    );
  }

  Widget _buildBinCard() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, -0.02))
          .animate(CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: _mapClosestBinController)),
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      _currentSelectedBin != null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: _currentSelectedBin.imageSrc,
                                    placeholder: (context, url) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                    imageBuilder: (context, imageprovider) {
                                      return Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          image: DecorationImage(
                                            image: imageprovider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              _currentSelectedBin != null
                                  ? _currentSelectedBin.binName
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              _currentSelectedBin != null
                                  ? "by: ${_currentSelectedBin.userName ?? ""}"
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (_currentSelectedBin != null)
                              Text(
                                _currentSelectedBin.taggedTime
                                            .toDaysAgo(DateTime.now()) >
                                        0
                                    ? "Added ${_currentSelectedBin.taggedTime.toDaysAgo(DateTime.now())} days ago."
                                    : "Added today!",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.start,
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: RaisedButton(
                                child: Text("Got Trash?"),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      GotTrashScreen.routeName,
                                      arguments: {
                                        "taggedBin": _currentSelectedBin
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Make sure to look around for the bin. \nIt may have moved a little. ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text("Bin not there?"),
                  //     FlatButton(
                  //       child: Text("Report It"),
                  //       onPressed: () {
                  //         Navigator.of(context).pushNamed(
                  //             GotTrashScreen.routeName,
                  //             arguments: {"taggedBin": _currentSelectedBin});
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              )),
        ),
      ),
    );
  }
}

// Future<void> _upload() async {
//   logger.info("Uploading bin ");
//   Position position = await Geolocator()
//       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   double x = 0.0001;
//   for (int i = 1; i < 100; i++) {
//     x += 0.001;
//     logger.info(i);
//     TaggedBin bin = TaggedBin(
//         id: "we",
//         binName: "Test Bin: $i",
//         imageSrc:
//             "https://firebasestorage.googleapis.com/v0/b/citycollection-38b54.appspot.com/o/findmybin%2F1JSRl3xuKcdmRqP4R5RSzhUTMPF2%2F2020-08-26T22%3A42%3A44.554108.jpg?alt=media&token=435c51fa-e40a-4622-a847-a99f689e6f73",
//         isNew: true,
//         locationLan: position.latitude + (new Random().nextDouble() * 0.1),
//         locationLon: position.longitude + (new Random().nextDouble() * 0.1),
//         pointsEarned: 0,
//         active: true,
//         reportStrikes: 0,
//         taggedTime: DateTime.now().millisecondsSinceEpoch,
//         userId: "1JSRl3xuKcdmRqP4R5RSzhUTMPF2");
//     TaggedBin bin2 = TaggedBin(
//         id: "we",
//         binName: "Test Bin: $i+1",
//         imageSrc:
//             "https://firebasestorage.googleapis.com/v0/b/citycollection-38b54.appspot.com/o/findmybin%2F1JSRl3xuKcdmRqP4R5RSzhUTMPF2%2F2020-08-26T22%3A42%3A44.554108.jpg?alt=media&token=435c51fa-e40a-4622-a847-a99f689e6f73",
//         isNew: true,
//         locationLan: position.latitude - (new Random().nextDouble() * 0.1),
//         locationLon: position.longitude + (new Random().nextDouble() * 0.1),
//         pointsEarned: 0,
//         active: true,
//         reportStrikes: 0,
//         taggedTime: DateTime.now().millisecondsSinceEpoch,
//         userId: "1JSRl3xuKcdmRqP4R5RSzhUTMPF2");
//     TaggedBin bin3 = TaggedBin(
//         id: "we",
//         binName: "Test Bin: $i",
//         imageSrc:
//             "https://firebasestorage.googleapis.com/v0/b/citycollection-38b54.appspot.com/o/findmybin%2F1JSRl3xuKcdmRqP4R5RSzhUTMPF2%2F2020-08-26T22%3A42%3A44.554108.jpg?alt=media&token=435c51fa-e40a-4622-a847-a99f689e6f73",
//         isNew: true,
//         locationLan: position.latitude + (new Random().nextDouble() * 1),
//         locationLon: position.longitude + (new Random().nextDouble() * 1),
//         pointsEarned: 0,
//         active: true,
//         reportStrikes: 0,
//         taggedTime: DateTime.now().millisecondsSinceEpoch,
//         userId: "1JSRl3xuKcdmRqP4R5RSzhUTMPF2");
//     TaggedBin bin4 = TaggedBin(
//         id: "we",
//         binName: "Test Bin: $i+1",
//         imageSrc:
//             "https://firebasestorage.googleapis.com/v0/b/citycollection-38b54.appspot.com/o/findmybin%2F1JSRl3xuKcdmRqP4R5RSzhUTMPF2%2F2020-08-26T22%3A42%3A44.554108.jpg?alt=media&token=435c51fa-e40a-4622-a847-a99f689e6f73",
//         isNew: true,
//         locationLan: position.latitude - (new Random().nextDouble() * 1),
//         locationLon: position.longitude + (new Random().nextDouble() * 1),
//         pointsEarned: 0,
//         active: true,
//         reportStrikes: 0,
//         taggedTime: DateTime.now().millisecondsSinceEpoch,
//         userId: "1JSRl3xuKcdmRqP4R5RSzhUTMPF2");
//     Map<String, dynamic> data = bin.toJson();
//     data.remove("id");
//     data.addAll({"userName": "Avinath"});
//     await Firestore.instance.collection("taggedBins").add(data);
//     Map<String, dynamic> data2 = bin2.toJson();
//     data.addAll({"userName": "Bruna"});
//     data2.remove("id");
//     await Firestore.instance.collection("taggedBins").add(data2);
//     Map<String, dynamic> data3 = bin3.toJson();
//     data.remove("id");
//     data.addAll({"userName": "Avinath"});
//     await Firestore.instance.collection("taggedBins").add(data3);
//     Map<String, dynamic> data4 = bin4.toJson();
//     data.addAll({"userName": "Bruna"});
//     data2.remove("id");
//     await Firestore.instance.collection("taggedBins").add(data4);
//   }
// }
