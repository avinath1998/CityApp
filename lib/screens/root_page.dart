import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/exceptions/authentication_exceptions.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/screens/authentication/onboarding_screen.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'home_screen.dart';
import 'general/large_loading_screen.dart';
import 'authentication/login_screen.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final Logger logger = Logger("Root Page State");
  bool _isShowingLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<AuthBloc>(context).add(CheckIfSignedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        cubit: BlocProvider.of<AuthBloc>(context),
        listener: (context, AuthState state) {
          if (state is SignedInState) {
            Navigator.of(context).pop();
            setState(() {
              if (_isShowingLoading) _isShowingLoading = false;
            });
          } else if (state is SignedOutState) {
            if (_isShowingLoading) {
              Navigator.of(context).pop();
            }
          } else if (state is SignInFailedState) {
            Navigator.of(context).pop();
            setState(() {
              if (_isShowingLoading) _isShowingLoading = false;
            });
            String errorMsg = "An error occured, try again";
            logger.info(state.exception);
            switch (state.exception) {
              case AuthenticationException.userNotFound:
                errorMsg =
                    "You haven't registered to use this app. Tap Sign Up below.";
                break;
              case AuthenticationException.userNotVerified:
                errorMsg =
                    "Your email still has not been verified, verify it to login.";
                break;
              case AuthenticationException.generalAuth:
                errorMsg = "An error occured, try again";
                break;
              case AuthenticationException.fetchFailed:
                errorMsg = "An error occured, try again";
                break;
              case AuthenticationException.invalidEmail:
                errorMsg = "Invalid email.";
                break;
              case AuthenticationException.wrongPassword:
                errorMsg = "Wrong password.";
                break;
              case AuthenticationException.userDisabled:
                errorMsg =
                    "Your account has been disabled, contact customer support.";
                break;
              case AuthenticationException.tooManyRequests:
                errorMsg =
                    "Hey, stop tryin to hack us!!!!! You've sent too many requests.";
                break;
              case AuthenticationException.operationNotAllowed:
                errorMsg =
                    "Whoops, looks like you've done something not allowed!";
                break;
            }
            showDialog(
                context: context,
                child: AlertDialog(
                  title: Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: Theme.of(context).errorColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Uh oh."),
                    ],
                  ),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          child: Text(
                        errorMsg,
                        textAlign: TextAlign.start,
                      ))
                    ],
                  ),
                  actions: [
                    RaisedButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
          } else if (state is SigningInWaitingState) {
            setState(() {
              _isShowingLoading = true;
            });
            showDialog(
                barrierDismissible: false,
                context: context,
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width > 400
                            ? 250.0
                            : 170,
                        width: MediaQuery.of(context).size.width > 400
                            ? 250.0
                            : 170,
                        child: FlareActor("assets/flare/earth_progress.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "rotate"),
                      ),
                      Text(
                        "Loading...",
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ));
          }
        },
        builder: (context, state) {
          if (state is SignedInState) {
            return HomeScreen();
          } else if (state is SignedOutState) {
            return LoginScreen();
          } else if (state is SignInFailedState) {
            return LoginScreen();
          } else if (state is SigningInWaitingState) {
            return LoginScreen();
          } else if (state is AuthUpdatedState) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }
}
