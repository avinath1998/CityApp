import 'dart:async';

import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';

class ThrowingTab extends StatefulWidget {
  final Function onContinueTapped;

  const ThrowingTab({
    Key key,
    this.onContinueTapped,
  }) : super(key: key);

  @override
  _ThrowingTabState createState() => _ThrowingTabState();
}

class _ThrowingTabState extends State<ThrowingTab>
    with SingleTickerProviderStateMixin {
  int _currentCountDown = 3;
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
    return Container(
      color: Colors.white,
      child: AnimatedSwitcher(
          switchOutCurve: Curves.easeIn,
          switchInCurve: Curves.easeOut,
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20.0),
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
                      "Throw your garbage into the bin.",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      _currentCountDown == 0
                          ? "Tap Continue"
                          : _currentCountDown.toString() + " seconds left.",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      onPressed: _currentCountDown > 0
                          ? null
                          : () {
                              widget.onContinueTapped();
                            },
                      color: CityColors.primary_teal,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
