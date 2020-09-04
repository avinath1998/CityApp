import 'dart:ui';

import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  final String errorMsg;
  final bool isWaiting;
  const LoginScreen({Key key, this.errorMsg, this.isWaiting = false})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String password;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child:
                                Image.asset("assets/images/ekva_no_tag.jpg")),
                        Container(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sign in",
                                style: Theme.of(context).textTheme.headline4,
                              )),
                        ),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: widget.errorMsg != null
                                      ? Text(widget.errorMsg)
                                      : Container()),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(hintText: "Email"),
                                initialValue: "avinath.2016041@iit.ac.lk",
                                validator: (val) {
                                  if (val == "") {
                                    return "Enter a valid email.";
                                  }
                                },
                                onSaved: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Password"),
                                style: Theme.of(context).textTheme.bodyText1,
                                initialValue: "password12",
                                obscureText: true,
                                validator: (val) {
                                  if (val == "") {
                                    return "Enter a valid password.";
                                  }
                                },
                                onSaved: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              !widget.isWaiting
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 20.0),
                                      child: Column(
                                        children: [
                                          RaisedButton(
                                            child: Text(
                                              "Login",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .signIn(name, password);
                                              }
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              "Forgot your password?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                BlocProvider.of<AuthBloc>(
                                                        context)
                                                    .signIn(name, password);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(top: 20.0),
                                      child: LinearProgressIndicator())
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black),
                              ),
                              FlatButton(
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegistrationScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
