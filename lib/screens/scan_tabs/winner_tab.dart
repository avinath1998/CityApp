import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';

class WinnerTab extends StatefulWidget {
  final ScanWinnings scanWinnings;

  const WinnerTab({Key key, this.scanWinnings}) : super(key: key);
  @override
  _WinnerTabState createState() => _WinnerTabState();
}

class _WinnerTabState extends State<WinnerTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 250.0,
                width: 250.0,
                child: widget.scanWinnings == null
                    ? FlareActor("assets/flare/earth_progress.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "rotate")
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
                              "You didn't win this time,",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "but thanks for playing!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Icon(FontAwesomeIcons.smile, color: Colors.white),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Share with your friends to join this initiative!",
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
                            Icon(FontAwesomeIcons.smile, color: Colors.white),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Share with your friends to join this initiative!",
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
                child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text(
                      "Go Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
