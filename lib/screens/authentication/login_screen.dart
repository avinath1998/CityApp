import 'dart:ui';

import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:citycollection/dialogs/ekva_alert_dialog.dart';
import 'package:citycollection/screens/authentication/forget_password_screen.dart';
import 'package:citycollection/screens/authentication/registration_screen.dart';
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
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                          child: Image.asset("assets/images/ekva_no_tag.jpg")),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sign in",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                "It Pays to Recycle! #Ekva",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
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
                              decoration: InputDecoration(
                                  hintText: "Email", icon: Icon(Icons.email)),
                              //initialValue: "avinath.2016041@iit.ac.lk",
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
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Password", icon: Icon(Icons.lock)),
                              style: Theme.of(context).textTheme.bodyText1,
                              // initialValue: "password12",
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
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();
                                              BlocProvider.of<AuthBloc>(context)
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
                                                .copyWith(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                ForgetPasswordScreen.routeName);
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
          )),
    );
  }
}
