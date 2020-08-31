import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class RegistrationScreen extends StatefulWidget {
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
              _isLoading = true;
            });
          } else if (state is RegistrationFailedState) {
            if (state.errorMsg != null && state.errorMsg.isNotEmpty) {
              setState(() {
                _errorMsg = "An error has occured, try again";
                _isLoading = false;
              });
            }
          } else if (state is RegistrationSuccessfulState) {
            setState(() {
              _errorMsg = null;
              _isDone = true;
              _isLoading = false;
            });
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
                    decoration: InputDecoration(hintText: "Password (Min 6)"),
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
                  _isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
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
                                  RegisterUserEvent(user, _values["password"]));
                            }
                          },
                        ),
                  _isDone ? Text("Done") : Text("Not Done"),
                  Text(
                    _errorMsg ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Theme.of(context).errorColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
