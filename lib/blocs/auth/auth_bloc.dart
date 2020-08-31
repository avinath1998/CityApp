import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/NoUserFoundException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final String TAG = "AUTHBLOC: ";
  final Logger logger = Logger("AuthBloc");
  CurrentUser currentUser;

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
    } else if (event is RegisterUserEvent) {
      yield* _registerEmail(event.user.email, event.password, event.user.name);
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

  Stream<AuthState> _registerEmail(
      String email, String password, String name) async* {
    try {
      print(TAG + "Registering");
      yield (RegistrationWaitingState());
      currentUser = await _authService.register(email, password, name);
      if (currentUser == null) {
        yield (RegistrationFailedState(
            NoUserFoundException("No user registered"),
            "Current User not registered"));
      } else {
        yield RegistrationSuccessfulState(currentUser);
        print(TAG + " Sign in Successful");
      }
    } on NoUserFoundException catch (ex) {
      print(TAG + " Could not sign in, user not found. $ex");
      yield SignInFailedState("Sorry, you are not registered to use this app.");
    } on DataFetchException catch (ex) {
      print(TAG + " Data could not be retrieved $ex");
      yield SignInFailedState("Oops! An error has occured, try again.");
    } on PlatformException catch (e) {
      logger.severe(e.message);
    }
  }

  Stream<AuthState> signOut() async* {
    await _authService.signOut();
  }
}
