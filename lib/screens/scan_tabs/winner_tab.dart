import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';

class WinnerTab extends StatefulWidget {
  final ScanWinnings scanWinnings;
  final bool isWaiting;
  const WinnerTab({Key key, this.scanWinnings, this.isWaiting})
      : super(key: key);

  @override
  _WinnerTabState createState() => _WinnerTabState();
}

class _WinnerTabState extends State<WinnerTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ScanBloc>(context).add(
        CheckWinningsEvent(BlocProvider.of<AuthBloc>(context).currentUser));
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      switchInCurve: Curves.elasticOut,
      switchOutCurve: Curves.linear,
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: widget.isWaiting
          ? _buildWaiting()
          : Container(
              child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.width > 400 ? 250.0 : 170,
                    width:
                        MediaQuery.of(context).size.width > 400 ? 250.0 : 170,
                    child: widget.scanWinnings == null
                        ? FlareActor("assets/flare/plant.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "start")
                        : FlareActor("assets/flare/trophy.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "show"),
                  ),
                  widget.scanWinnings == null
                      ? Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                gradient: LinearGradient(colors: [
                                  CityColors.primary_teal,
                                  CityColors.primary_teal[200],
                                ])),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Thanks for the trash!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Keep playing to try and win!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(FontAwesomeIcons.smile,
                                    color: Colors.white),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tell your friends to join this initiative!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "#ekvalanka #plasticwastefreelanka",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                gradient: LinearGradient(colors: [
                                  CityColors.primary_teal,
                                  CityColors.primary_teal[100]
                                ])),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Congratulations! You've won!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.scanWinnings.winnings} LKR worth of a prize!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "Please inform someone from our team!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(FontAwesomeIcons.smile,
                                    color: Colors.white),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tell your friends to join this initiative!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: CityColors.primary_teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )),
    );
  }

  Widget _buildWaiting() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width > 400 ? 250.0 : 170,
            width: MediaQuery.of(context).size.width > 400 ? 250.0 : 170,
            child: FlareActor("assets/flare/earth_progress.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "rotate"),
          ),
          Card(
            color: CityColors.primary_teal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  gradient: LinearGradient(colors: [
                    CityColors.primary_teal,
                    CityColors.primary_teal[400],
                  ])),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Thanks for recycling!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Let's reduce plastic waste together!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "Checking if you've won!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Loading(
                      indicator: BallScaleMultipleIndicator(),
                      size: 70.0,
                      color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
