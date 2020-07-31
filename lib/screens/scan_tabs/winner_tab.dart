import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/blocs/bin_scan_steps/bin_scan_steps_bloc.dart';
import 'package:citycollection/blocs/scan/scan_bloc.dart';
import 'package:citycollection/blocs/winner_tab/winner_tab_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading/indicator/ball_scale_multiple_indicator.dart';
import 'package:loading/loading.dart';
import 'package:logging/logging.dart';
import 'package:share/share.dart';

class WinnerTab extends StatefulWidget {
  final Function onFailedToGetWinnings;
  final Function(ScanWinnings, String) onRedeemed;
  final Function() onLose;
  const WinnerTab({
    Key key,
    this.onFailedToGetWinnings,
    this.onRedeemed,
    this.onLose,
  }) : super(key: key);
  @override
  _WinnerTabState createState() => _WinnerTabState();
}

class _WinnerTabState extends State<WinnerTab> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _phoneNumber = "";
  WinnerTabBloc _winnerTabBloc;
  bool _isWaiting = false;
  ScanWinnings _scanWinnings;
  final Logger logger = Logger("WinnerTabState");
  bool _isPhoneValid = false;
  bool _isPhoneSaving = false;
  bool _isPhoneSaved = false;
  bool _hasPhoneErrorSavingOccured = false;

  @override
  void initState() {
    super.initState();
    _winnerTabBloc = WinnerTabBloc(GetIt.instance<DataRepository>(),
        BlocProvider.of<AuthBloc>(context).currentUser);
    _winnerTabBloc.add(FetchWinningsEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _winnerTabBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return BlocListener(
      bloc: _winnerTabBloc,
      listener: (context, state) {
        logger.info("State changed");
        if (state is UserWonState) {
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _isWaiting = false;
              _scanWinnings = state.scanWinnings;
            });
          });
        } else if (state is UserLostState) {
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _isWaiting = false;
            });
            widget.onLose();
          });
        } else if (state is LoadingWinningsState) {
          setState(() {
            _isWaiting = true;
          });
        } else if (state is FailedLoadingWinningsState) {
          widget.onFailedToGetWinnings();
        } else if (state is WinningFormLoadingState) {
          setState(() {
            _isPhoneSaving = true;
            _isPhoneSaving = false;
            _hasPhoneErrorSavingOccured = false;
          });
        } else if (state is WinningFormSavedState) {
          setState(() {
            _isPhoneSaving = false;
            _isPhoneSaved = true;
            _hasPhoneErrorSavingOccured = false;
          });
        } else if (state is WinningFormFailedState) {
          setState(() {
            _isPhoneSaving = false;
            _isPhoneSaved = false;
            _hasPhoneErrorSavingOccured = true;
          });
        }
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        switchInCurve: Curves.elasticOut,
        switchOutCurve: Curves.linear,
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: _isWaiting
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
                      child: _scanWinnings == null
                          ? FlareActor("assets/flare/plant.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "start")
                          : FlareActor("assets/flare/trophy.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "show"),
                    ),
                    _scanWinnings == null
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
                                    "Try again to win!",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Share.share(
                                          'Take a picture of your garbage for free prizes! Download Ekva Now: https://play.google.com/store/apps/details?id=com.city.citycollection&hl=en');
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "#ekvalanka #wastefreelanka",
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
                                    CityColors.primary_teal[300]
                                  ])),
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    "Congratulations! You've won a",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${_scanWinnings.winnings} LKR prize!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
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
                                    "Enter your phone number to redeem!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child:
                                                InternationalPhoneNumberInput(
                                              initialValue: PhoneNumber(),
                                              countries: ["LK"],
                                              maxLength: 11,
                                              ignoreBlank: true,
                                              onInputValidated: (val) {
                                                setState(() {
                                                  _isPhoneValid = val;
                                                });
                                              },
                                              errorMessage:
                                                  "Invalid phone number",
                                              autoValidate: true,
                                              onSubmit: () {},
                                              inputDecoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  hintText: "Phone Number",
                                                  fillColor: Colors.white),
                                              onInputChanged: (number) {
                                                setState(() {
                                                  _phoneNumber =
                                                      number.toString();
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(height: 10.0),
                    _scanWinnings == null
                        ? RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: CityColors.primary_teal,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Done",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : LayoutBuilder(builder: (context, constraints) {
                            if (_isPhoneSaving) {
                              return CircularProgressIndicator();
                            } else if (_isPhoneSaved) {
                              return Icon(Icons.check,
                                  color: CityColors.primary_teal);
                            } else if (_hasPhoneErrorSavingOccured) {
                              return RaisedButton(
                                onPressed: _isPhoneValid
                                    ? () {
                                        logger.info(_phoneNumber);
                                        widget.onRedeemed(
                                            _scanWinnings, _phoneNumber);
                                      }
                                    : null,
                                color: CityColors.primary_teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Try Again",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              return RaisedButton(
                                onPressed: _isPhoneValid
                                    ? () {
                                        logger.info(_phoneNumber);
                                        widget.onRedeemed(
                                            _scanWinnings, _phoneNumber);
                                      }
                                    : null,
                                color: CityColors.primary_teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Redeem",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          })
                  ],
                ),
              )),
      ),
    );
  }

  Widget _buildWaiting() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width > 400 ? 270.0 : 190,
            width: MediaQuery.of(context).size.width > 400 ? 270.0 : 190,
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
                    "Thanks for disposing!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Let's reduce litter together!",
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
