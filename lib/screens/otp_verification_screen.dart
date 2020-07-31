import 'package:citycollection/blocs/auth/auth_bloc.dart';
import 'package:citycollection/configurations/city_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPVerification extends StatefulWidget {
  final Function(bool) onComplete;
  final String phoneNumber;

  const OTPVerification({
    Key key,
    this.onComplete,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final Logger logger = Logger("OTPVerificationState");
  bool _isDoneEnabled = false;
  bool _isOTPValid = false;
  bool _isOTPFailed = false;
  bool _isOTPLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context)
        .add(SignInPhoneNumber(widget.phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerificationCodeSentState) {
          logger.info("verification code sent");
          setState(() {
            _isOTPLoading = false;
            _isOTPValid = false;
            _isOTPFailed = false;
          });
          logger.info(_isOTPLoading);
        } else if (state is VerificationCodeValidState) {
          logger.info("Verificaiton code is valid");
          setState(() {
            _isOTPValid = true;
            _isOTPFailed = false;
            _isOTPLoading = false;
          });
          widget.onComplete(true);
        } else if (state is VerificationCodeFailedState) {
          logger.info("Failed varification");
          setState(() {
            _isOTPFailed = true;
            _isOTPValid = false;
            _isOTPLoading = false;
          });
          widget.onComplete(false);
        }
      },
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("A passcode has been\nsent to your phone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (_isOTPValid) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CityColors.primary_teal,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.check, color: Colors.white),
                    );
                  } else if (_isOTPFailed) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(Icons.error_outline, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("Invalid code, try again.")
                      ],
                    );
                  } else {
                    return Text("Enter the passcode here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300));
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              OTPTextField(
                length: 6,
                width: 300,
                fieldWidth: 30,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  logger.info("Alright this is the $pin");
                  BlocProvider.of<AuthBloc>(context)
                      .add(AuthCodeEnteredEvent(pin));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  !_isOTPLoading
                      ? FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300)),
                        )
                      : CircularProgressIndicator(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
