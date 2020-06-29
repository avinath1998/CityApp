import 'dart:async';

import 'package:citycollection/configurations/city_colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';

class ThrowingTab extends StatefulWidget {
  final isWinner;

  const ThrowingTab({
    Key key,
    this.isWinner,
  }) : super(key: key);

  @override
  _ThrowingTabState createState() => _ThrowingTabState();
}

class _ThrowingTabState extends State<ThrowingTab>
    with SingleTickerProviderStateMixin {
  int _currentCountDown = 7;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(Duration(seconds: 1), (t) {
        if (_currentCountDown > 0) {
          setState(() {
            _currentCountDown -= 1;
          });
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchOutCurve: Curves.easeIn,
      switchInCurve: Curves.easeOut,
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: _currentCountDown > 0
          ? Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/trash_disposal.jpg"),
                  Column(
                    key: Key("ColumnThrowFirst"),
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Throw your item into the bin.",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        _currentCountDown.toString() + " seconds left.",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 250.0,
                    width: 250.0,
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
                            "Thanks for your contribution to a sustainable future.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Let's reduce plastic waste together!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Checking if you've won a prize!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Loading(
                              indicator: BallScaleMultipleIndicator(),
                              size: 100.0,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
