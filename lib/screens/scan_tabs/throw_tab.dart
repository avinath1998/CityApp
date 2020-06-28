import 'dart:async';

import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';

class ThrowingTab extends StatefulWidget {
  const ThrowingTab({
    Key key,
  }) : super(key: key);

  @override
  _ThrowingTabState createState() => _ThrowingTabState();
}

class _ThrowingTabState extends State<ThrowingTab> {
  int _currentCountDown = 10;
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset("assets/images/trash_disposal.jpg"),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  switchInCurve: Curves.easeOut,
                  child: _currentCountDown > 0
                      ? Column(
                          key: Key("ColumnThrowFirst"),
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Throw your item into the bin.",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              _currentCountDown.toString() + " seconds left.",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        )
                      : Column(
                          key: Key("ColumnThrowSecond"),
                          children: <Widget>[
                            Text(
                              "Checking to see if you won..",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
