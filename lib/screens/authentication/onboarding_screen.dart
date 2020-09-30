import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';

class OnboardingScreen extends StatefulWidget {
  final String errorMsg;
  final bool isWaiting;

  const OnboardingScreen({Key key, this.errorMsg, this.isWaiting})
      : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildOnboarding());
  }

  Widget _buildOnboarding() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [CityColors.primary_teal, CityColors.primary_teal[700]])),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
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
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
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
                        "Stand a chance to win when you throw away your plastic waste!",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
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
                        "Steps:",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "1. Find an Ekva plastic garbage bin",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "2. Scan the QR on the bin",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "3. Take a picture of your plastic item",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "4. Stand a chance to win a prize",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      switchInCurve: Curves.elasticOut,
                      transitionBuilder: (child, transition) {
                        return ScaleTransition(
                          child: child,
                          scale: transition,
                        );
                      },
                      child: !widget.isWaiting
                          ? RaisedButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .signIn("a", "a");
                              },
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "Start",
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                            )
                          : CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
