import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/data_fetch_exception.dart';
import 'package:citycollection/exceptions/no_user_found_exception.dart';
import 'package:citycollection/exceptions/authentication_exceptions.dart';
import 'package:citycollection/exceptions/user_not_verified_exception.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:citycollection/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final DataRepository _dataRepository;
  final String TAG = "AUTHBLOC: ";
  final Logger logger = Logger("AuthBloc");
  CurrentUser currentUser;

  AuthBloc(this._authService, this._dataRepository) : super(AuthInitial());

  void signIn(String email, String password) {
    add(SignInEvent(email, password));
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield* _signIn(event.email, event.password);
    } else if (event is SignOutEvent) {
      yield* _signOut();
    } else if (event is CheckIfSignedInEvent) {
      yield* _checkIfSignedIn();
    } else if (event is RegisterUserEvent) {
      yield* _registerEmail(
          event.user.email, event.password, event.user.name, event.dob);
    } else if (event is LoadUserEvent) {
      yield* _loadCurrentUser(event.user.id, event.forceNetwork);
    } else if (event is ForgetPasswordEvent) {
      yield* _resetPasswordEvent(event.email);
    }
  }

  Stream<AuthState> _resetPasswordEvent(String email) async* {
    try {
      yield ForgetPasswordSendingState();
      await Future.delayed(Duration(seconds: 1));
      await _authService.resetPassword(email);
      yield ForgetPasswordSentState();
    } on Exception catch (e) {
      logger.severe(e.runtimeType);
      yield ForgetPasswordFailedSendingState(
          AuthenticationException.generalAuth);
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
    } catch (e) {
      logger.severe(e.toString());
      yield SignedOutState();
    }
  }

  Stream<AuthState> _signIn(String email, String password) async* {
    try {
      print(TAG + " Signing in.");
      yield (SigningInWaitingState());
      currentUser = await _authService.signIn(email, password);
      if (currentUser == null) {
        yield (SignInFailedState("An error occured signing in, try again",
            AuthenticationException.userNotFound));
      } else {
        yield SignedInState(currentUser);
      }
      print(TAG + " Sign in Successful");
    } on NoUserFoundException catch (ex) {
      print(TAG + " Could not sign in, user not found. $ex");
      yield SignInFailedState("Sorry, you are not registered to use this app.",
          AuthenticationException.userNotFound);
    } on DataFetchException catch (ex) {
      print(TAG + " Data could not be retrieved $ex");
      yield SignInFailedState("Oops! An error has occured, try again.",
          AuthenticationException.fetchFailed);
    } on UserNotVerifiedException catch (ex) {
      yield SignInFailedState("Oops! An error has occured, try again.",
          AuthenticationException.userNotVerified);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.invalidEmail);
          break;
        case "wrong-password":
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.wrongPassword);
          break;
        case "user-not-found":
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.userNotFound);
          break;
        case "user-disabled":
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.userDisabled);
          break;
        case "too-many-requests":
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.tooManyRequests);
          break;
        case "operation-not-allowed":
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.operationNotAllowed);
          break;
        default:
          yield SignInFailedState("Oops! An error has occured, try again.",
              AuthenticationException.generalAuth);
      }
    } catch (ex) {
      yield SignInFailedState("Oops! An error has occured, try again.",
          AuthenticationException.generalAuth);
    }
  }

  Stream<AuthState> _registerEmail(
      String email, String password, String name, DateTime dob) async* {
    try {
      print(TAG + "Registering");
      yield (RegistrationWaitingState());
      currentUser = await _authService.register(email, password, name, dob);

      if (currentUser == null) {
        yield (RegistrationFailedState(
            "No user found", RegistrationException.userNotSaved));
      } else {
        yield RegistrationSuccessfulState(currentUser);
        print(TAG + " Sign in Successful");
      }
    } on DataFetchException catch (e) {
      yield RegistrationFailedState(
          e.errorMsg, RegistrationException.userNotSaved);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          yield RegistrationFailedState(
              e.message, RegistrationException.errorWeakPassword);
          break;
        case "invalid-email":
          yield RegistrationFailedState(
              e.message, RegistrationException.invalidEmail);
          break;
        case "email-already-in-use":
          yield RegistrationFailedState(
              e.message, RegistrationException.emailAreadyInUse);
          break;
      }
    } catch (e, stk) {
      logger.severe(stk);
      logger.severe(e.toString());
      yield RegistrationFailedState(
          e.toString(), RegistrationException.generalAuth);
    }
  }

  Stream<AuthState> _loadCurrentUser(
      final String id, final bool forceNetwork) async* {
    try {
      if (forceNetwork || currentUser == null) {
        logger.info("Loading current user from database");
        currentUser = await _dataRepository.fetchCurrentUser(id);
      }
      yield AuthUpdatedState(currentUser);
    } on DataFetchException catch (e) {
      yield AuthUpdateFailedState(e);
    }
  }

  Stream<AuthState> _signOut() async* {
    await _authService.signOut();
    yield SignedOutState();
  }
}
