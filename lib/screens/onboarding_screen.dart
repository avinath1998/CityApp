import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/home_screen.dart';
import 'package:citycollection/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_grid_pulse_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';

class OnboardingScreen extends StatefulWidget {
  final String errorMsg;
  final bool isWaiting;

  const OnboardingScreen({Key key, this.errorMsg, this.isWaiting = false})
      : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/images/login_bg.jpg",
                colorBlendMode: BlendMode.darken,
                fit: BoxFit.cover,
                color: Colors.black45,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 80.0),
                height: 350,
                width: 350,
                child: Image.asset(
                  "assets/images/logo_secondary.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Welcome to Ekva.",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                          Text(
                            "The app that pays you to recycle.",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.center,
                              width: 30.0,
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: !widget.isWaiting
                                        ? Container(
                                            child: Text(
                                              "Start",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                          )
                                        : CircularProgressIndicator(
                                            backgroundColor: Colors.white),
                                  ),
                                  color: CityColors.primary_teal,
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context)
                                        .signIn("email", "a");
                                  },
                                ),
                              )),
                          widget.errorMsg != null
                              ? Text(widget.errorMsg)
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
