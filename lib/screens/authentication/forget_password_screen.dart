import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "ForgetPasswordScreen";

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _errorMsg;
  bool _sent = false;
  bool _isLoading = false;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Forget your password?",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          "Enter your email below.",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email Address"),
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
                        _email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordSentState) {
                        setState(() {
                          _isLoading = false;
                          _sent = true;
                          _errorMsg = null;
                        });
                      } else if (state is ForgetPasswordFailedSendingState) {
                        setState(() {
                          _isLoading = false;
                          _sent = false;
                          _errorMsg =
                              "An error has occured, double check the email you gave.";
                        });
                      } else if (state is ForgetPasswordSendingState) {
                        setState(() {
                          _isLoading = true;
                          _sent = false;
                          _errorMsg = null;
                        });
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isLoading) CircularProgressIndicator(),
                        if (_sent)
                          Text(
                              "Successfully sent reset email, check your email.",
                              textAlign: TextAlign.center),
                        if (_errorMsg != null)
                          Text(
                            _errorMsg,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Theme.of(context).errorColor),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        if (!_sent)
                          RaisedButton(
                            child: Text(
                              "Reset",
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                BlocProvider.of<AuthBloc>(context)
                                    .add(ForgetPasswordEvent(_email));
                              }
                            },
                          ),
                        if (_sent)
                          FlatButton(
                            child: Text(
                              "Go to Login",
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
