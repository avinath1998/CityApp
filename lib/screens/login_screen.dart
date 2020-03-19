import 'dart:ui';

import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
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
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 40.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                              fontSize: 35, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Welcome',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: 'To',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                                text: 'City.',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: CityColors.primary_green)),
                          ],
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                    fontSize: 25, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Sign',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'In',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.all(10.0),
                            child: widget.errorMsg != null
                                ? Text(widget.errorMsg)
                                : Container()),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.body1,
                          decoration: InputDecoration(hintText: "Email"),
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
                          decoration: InputDecoration(hintText: "Password"),
                          style: Theme.of(context).textTheme.body1,
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
                                child: FlatButton(
                                  child: Text("Login",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      BlocProvider.of<AuthBloc>(context)
                                          .signIn(name, password);
                                    }
                                  },
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: LinearProgressIndicator())
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
