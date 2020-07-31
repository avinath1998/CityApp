import 'package:cached_network_image/cached_network_image.dart';
import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tab_bloc.dart';
import 'package:citycollection/blocs/home_tab/home_tabs.dart';
import 'package:citycollection/blocs/nearby_bins/nearby_bins_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/live_bin_setting.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:citycollection/screens/home_tabs/schedule_tab.dart';
import 'package:citycollection/screens/scan_screen.dart';
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
import 'package:permission_handler/permission_handler.dart';
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
  final Logger logger = Logger("HomeScreenState");
  HomeTabBloc _homeTabBloc;
  NearbyBinsBloc _nearbyBinsBloc;
  int _currentSelectedBottomNav = 0;
  AnimationController _cardSlideController;
  AnimationController _backController;
  AnimationController _mapClosestBinController;
  Animation<double> _radiusAnimation;
  ScrollController _scrollController;
  TaggedBin _currentSelectedBin;

  @override
  void initState() {
    super.initState();
    _homeTabBloc = HomeTabBloc();
    // _nearbyBinsBloc =
    //     NearbyBinsBloc(GetIt.instance<DataRepository>(), Geolocator());
    _cardSlideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _backController = AnimationController(
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
      //_nearbyBinsBloc.add(InitializeCurrentLocationEvent());
      //_nearbyBinsBloc.add(OpenBinStreamEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _backController.dispose();
    _cardSlideController.dispose();
    // _nearbyBinsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _nearbyBinsBloc,
        ),
        BlocProvider(
          create: (context) => _homeTabBloc,
        )
      ],
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              CityColors.primary_teal,
              CityColors.primary_teal[700]
            ])),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(child: child, scale: animation);
              },
              switchInCurve: Curves.easeOut,
              layoutBuilder: (context, widgets) {
                return _buildLiveHappening();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiveHappening() {
    return Container(
      key: Key("LiveContainer"),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width > 400 ? 150.0 : 100,
                      child: Material(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            child: Image.asset(
                                "assets/images/ekva_primary_light.jpg")),
                      )),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: Text(
                        "Hi,",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: Text(
                        "Win prizes for throwing away your trash.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 35,
                    child: Divider(
                      thickness: 3,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "1. Find a ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(FontAwesomeIcons.trashAlt,
                        color: Colors.white, size: 30),
                    Text(
                      " anywhere.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "2. Take a ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    Text(
                      " of ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(FontAwesomeIcons.trashAlt,
                        color: Colors.white, size: 30),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "3. Take a ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    Text(
                      " of ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Image.asset(
                      "assets/images/water.png",
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: Text(
                        "4. Win Prizes!",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      FontAwesomeIcons.dollarSign,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () async {
                      if (await Permission.camera.request().isGranted) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  title: Text("Please Don't Cheat!",
                                      style: TextStyle(
                                        color: Colors.red,
                                      )),
                                  content: Text(
                                    "Do not cheat and take pictures of the same garbage item.\n\nYou will be disqualified if you do!",
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: Text("Ok"),
                                      color: CityColors.primary_teal,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ScanScreen()));
                                      },
                                    )
                                  ],
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                  title: Text("Whoops!"),
                                  content: Text(
                                    "Please allow camera permissions to scan a bin.",
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ));
                      }
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Start",
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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
                bloc: _homeTabBloc,
                listener: (context, state) async {
                  if (state is HomeTabNearbyState) {
                    _cardSlideController.reverse();
                    //_mapClosestBinController.forward();
                  } else if (state is HomeTabAddBinState) {
                    _mapClosestBinController.reverse();
                    _cardSlideController.reverse();
                    //_cardSlideController.forward();
                  } else if (state is HomeTabTrophiesState) {
                    _mapClosestBinController.reverse();
                    _cardSlideController.forward();
                  } else if (state is HomeTabMeState) {
                    _cardSlideController.reverse();
                    _mapClosestBinController.reverse();
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
                  } else if (state is ScanScreenState) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ScanScreen()));
                  } else {
                    _cardSlideController.reverse();
                  }
                },
              ),
              BlocListener(
                bloc: _nearbyBinsBloc,
                listener: (context, state) async {
                  if (state is SelectedBinState) {
                    if (_mapClosestBinController.isCompleted) {
                      await _mapClosestBinController.reverse();
                    }
                    setState(() {
                      _currentSelectedBin = state.bin;
                    });
                    logger.info("Nearby: ${state}");
                    await _mapClosestBinController.forward();
                  }
                },
              )
            ],
            child: Stack(
              alignment: Alignment.bottomCenter,
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
              activeColor: CityColors.primary_teal,
              inactiveColor: Colors.black54,
              items: [
                TitledNavigationBarItem(title: 'Map', icon: Icons.map),
                TitledNavigationBarItem(title: 'Add Bin', icon: Icons.add),
                TitledNavigationBarItem(
                    title: 'Leaderboard', icon: FontAwesomeIcons.trophy),
                TitledNavigationBarItem(
                    title: 'Me', icon: Icons.account_circle),
              ]),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ScanScreen()));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBinCard() {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, -0.02))
          .animate(CurvedAnimation(
              curve: Curves.ease, parent: _mapClosestBinController)),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // GestureDetector(
                //   onTap: () {
                //     _mapClosestBinController.reverse();
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.only(bottom: 10.0),
                //     child: Icon(
                //       Icons.keyboard_arrow_down,
                //       color: Colors.white,
                //       size: 25.0,
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          _currentSelectedBin != null
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: CachedNetworkImage(
                                    imageUrl: _currentSelectedBin.imageSrc,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    imageBuilder: (context, imageprovider) {
                                      return Container(
                                        height: 140,
                                        width: 160,
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
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            _currentSelectedBin != null
                                ? _currentSelectedBin.binName
                                : "",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          Text(
                            _currentSelectedBin != null
                                ? "Submitted by: Avinath"
                                : "",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              color: CityColors.primary_teal,
                              child: Text("Go",
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
        ),
      ),
    );
  }
}
