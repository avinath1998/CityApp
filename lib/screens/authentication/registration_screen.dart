import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/exceptions/authentication_exceptions.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "/registration";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _values = Map();
  final Logger logger = Logger("RegistrationScreenState");
  bool _isLoading = false;
  String _errorMsg;
  bool _isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegistrationWaitingState) {
            setState(() {
              _errorMsg = null;
              _isLoading = true;
            });
          } else if (state is RegistrationFailedState) {
            String error = "An error has occured, try again";
            switch (state.exception) {
              case RegistrationException.userNotSaved:
                break;
              case RegistrationException.errorWeakPassword:
                error = "That password is too weak, enter a stronger one";
                break;
              case RegistrationException.invalidEmail:
                error = "That email is invalid!";
                break;
              case RegistrationException.emailAreadyInUse:
                error = "That email is already registered!";
                break;
              case RegistrationException.generalAuth:
                break;
            }
            setState(() {
              _errorMsg = error;
              _isLoading = false;
            });
          } else if (state is RegistrationSuccessfulState) {
            setState(() {
              _errorMsg = null;
              _isDone = true;
              _isLoading = false;
            });
            FocusScope.of(context).unfocus();
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Register",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: "Avinath Gunasekara",
                    decoration: InputDecoration(hintText: "First Name"),
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: (val) {
                      if (val == "") {
                        return "Enter a valid name.";
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _values["name"] = val;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: "avinath.2016041@iit.ac.lk",
                    decoration: InputDecoration(hintText: "E-mail"),
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: (val) {
                      if (val == "" ||
                          !val.contains("@") ||
                          !val.contains(".")) {
                        return "Enter a valid email.";
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _values["email"] = val;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: "password12",
                    decoration: InputDecoration(
                        hintText: "Password (Min 6 Characters)"),
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: true,
                    validator: (val) {
                      if (val == "" || val.length < 6) {
                        return "Enter a valid password.";
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _values["password"] = val;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: "password12",
                    decoration: InputDecoration(hintText: "Confirm Password"),
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: true,
                    validator: (val) {
                      if (val == "" || val.length < 6) {
                        return "Enter a valid password.";
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _values["conPassword"] = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    _errorMsg ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Theme.of(context).errorColor),
                  ),
                  AnimatedSwitcher(
                      duration: Duration(milliseconds: 100),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : LayoutBuilder(
                              builder: (context, constraints) {
                                if (!_isDone) {
                                  return RaisedButton(
                                    child: Text(
                                      "Register",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        CurrentUser user = CurrentUser(
                                            name: _values["name"],
                                            email: _values["email"]);
                                        logger.info(user);
                                        BlocProvider.of<AuthBloc>(context).add(
                                            RegisterUserEvent(
                                                user,
                                                _values["password"],
                                                DateTime.now()));
                                      }
                                    },
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Registered, a confirmation link has been sent to your email.",
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      RaisedButton(
                                        child: Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).popUntil(
                                              ModalRoute.withName(
                                                  LoginScreen.routeName));
                                        },
                                      ),
                                    ],
                                  );
                                }
                              },
                            )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
