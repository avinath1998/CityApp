import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/exceptions/authentication_exceptions.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:citycollection/networking/db.dart';
import 'package:citycollection/screens/onboarding_screen.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'home_screen.dart';
import 'large_loading_screen.dart';
import 'login_screen.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
    //BlocProvider.of<AuthBloc>(context).add(CheckIfSignedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, AuthState state) {
        if (state is SignedInState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeScreen.routeName, ModalRoute.withName(LoginScreen.routeName));
        } else if (state is SignedOutState) {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(LoginScreen.routeName));
        } else if (state is SignInFailedState) {
          Navigator.of(context)
              .popUntil(ModalRoute.withName(LoginScreen.routeName));
          String errorMsg = "An error occured, try again";
          switch (state.exception) {
            case AuthenticationException.userNotFound:
              errorMsg = "You haven't registered to use this app";
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
                      textAlign: TextAlign.center,
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
          showDialog(
              barrierDismissible: false,
              context: context,
              child: AlertDialog(
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [CircularProgressIndicator(), Text("Signing in")],
                ),
              ));
        } else if (state is AuthInitial) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        }
      },
      child: Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text("Start"),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
