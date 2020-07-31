import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/NoUserFoundException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final String TAG = "AUTHBLOC: ";
  final Logger logger = Logger("AuthBloc");
  CurrentUser currentUser;
  String _currentVerificationId;

  AuthBloc(this._authService);

  void signIn(String email, String password) {
    add(SignInEvent(email, password));
  }

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield* _signIn(event.email, event.password);
    } else if (event is SignOutEvent) {
      yield* signOut();
    } else if (event is CheckIfSignedInEvent) {
      yield* _checkIfSignedIn();
    } else if (event is SignInPhoneNumber) {
      yield* _signInPhoneNumber(event.phoneNumber);
    } else if (event is AuthCodeEnteredEvent) {
      yield* _verifyCode(event.passcode);
    }
  }

  Stream<AuthState> _signInPhoneNumber(String phoneNumber) async* {
    yield VerificationCodeSentState();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (credential) {
          logger.info("Verification Completed");
        },
        verificationFailed: (e) {
          logger.severe("Verification Failed: ${e.message}");
        },
        codeSent: (code, [value]) {
          _currentVerificationId = code;
        },
        codeAutoRetrievalTimeout: (out) {
          logger.severe("Code Timeout");
        });
  }

  Stream<AuthState> _verifyCode(String code) async* {
    yield VerificationCodeSentState();
    logger.info(_currentVerificationId);
    _currentVerificationId = "123123";
    if (_currentVerificationId != null) {
      AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: _currentVerificationId, smsCode: code);
      if (credential != null) {
        AuthResult result =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (result != null) {
          yield VerificationCodeValidState(result);
        } else {
          yield VerificationCodeFailedState();
        }
      } else {
        yield VerificationCodeFailedState();
      }
    } else {
      yield VerificationCodeFailedState();
    }
  }

  Stream<AuthState> _checkIfSignedIn() async* {
    try {
      print(TAG + " Prior Checking Signing in.");
      yield (SigningInWaitingState());
      currentUser = await _authService.checkIfAlreadySignedIn();
      if (currentUser == null) {
        yield (SignedOutState());
      } else {
        yield SignedInState(currentUser);
        print(TAG + " Sign in Successful");
      }
    } on NoUserFoundException catch (ex) {
      print(TAG + " Could not sign in, user not found. $ex");
      yield SignedOutState();
    } on DataFetchException catch (ex) {
      print(TAG + " Data could not be retrieved $ex");
      yield SignedOutState();
    }
  }

  Stream<AuthState> _signIn(String email, String password) async* {
    try {
      print(TAG + " Signing in.");
      yield (SigningInWaitingState());
      currentUser = await _authService.anonSignIn();
      if (currentUser == null) {
        yield (SigningInWaitingState());
      } else {
        yield SignedInState(currentUser);
      }
      print(TAG + " Sign in Successful");
    } on NoUserFoundException catch (ex) {
      print(TAG + " Could not sign in, user not found. $ex");
      yield SignInFailedState("Sorry, you are not registered to use this app.");
    } on DataFetchException catch (ex) {
      print(TAG + " Data could not be retrieved $ex");
      yield SignInFailedState("Oops! An error has occured, try again.");
    }
  }

  Stream<AuthState> signOut() async* {
    await _authService.signOut();
  }
}
