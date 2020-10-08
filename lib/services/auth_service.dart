import 'package:citycollection/exceptions/data_fetch_exception.dart';
import 'package:citycollection/exceptions/no_user_found_exception.dart';
import 'package:citycollection/exceptions/user_not_verified_exception.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/networking/repositories/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

abstract class AuthService {
  Future<CurrentUser> signIn(String email, String password);
  Future<CurrentUser> checkIfAlreadySignedIn();
  Future<void> signOut();
  Future<CurrentUser> anonSignIn();
  Future<void> resetPassword(String email);
  Future<void> sendConfirmationEmail(UserCredential user);
  Future<CurrentUser> register(
      String email, String password, String name, DateTime dob);
}

class FirebaseAuthService implements AuthService {
  String TAG = "FIREBASEAUTHSERVICE: ";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger logger = Logger("FirebaseAuthService");
  @override
  Future<CurrentUser> signIn(String email, String password) async {
    print(TAG + " Signing in");
    var result = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      logger.info(e.toString);
      throw e;
    });

    if (result.user == null) {
      throw NoUserFoundException("Credentials not found!");
    } else {
      print(TAG + " User has been Found. ${result.user.uid}");
    }
    if (!result.user.emailVerified) {
      throw UserNotVerifiedException("Not Verified");
    }
    try {
      CurrentUser user = await GetIt.instance<DataRepository>()
          .fetchCurrentUser(result.user.uid);
      if (user == null) {
        print(TAG + " User not saved in database ${result.user.uid}");
        throw NoUserFoundException("User not saved in database");
      } else {
        print(TAG + " Returning user to calling function ${result.user.uid}");

        return user;
      }
    } on DataFetchException catch (e) {
      throw DataFetchException(e.errorMsg);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<CurrentUser> checkIfAlreadySignedIn() async {
    User user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print(TAG + " Current user not found, user is signed out");
      return null;
    } else {
      print(TAG + " Current user found, user is signed in!");
      try {
        CurrentUser currentUser =
            await GetIt.instance<DataRepository>().fetchCurrentUser(user.uid);
        if (user == null) {
          print(TAG + " User not saved in database ${user.uid}");
          throw NoUserFoundException("User not saved in database");
        } else {
          print(TAG + " Returning user to calling function ${user.uid}");

          return currentUser;
        }
      } on DataFetchException catch (e) {
        throw DataFetchException(e.errorMsg);
      }
    }
  }

  @override
  Future<CurrentUser> anonSignIn() async {
    logger.info("Anonymously Signing in");
    UserCredential result = await FirebaseAuth.instance.signInAnonymously();
    logger.info("User's phone number: ${result.user.phoneNumber}");
    CurrentUser currentUser;
    if (result != null) {
      if (result.user != null) {
        currentUser = CurrentUser(id: result.user.uid);
        logger.info("Anonymously Signed in: ${currentUser.id}");
      } else {
        logger.severe("user could not be found in auth result");
      }
    } else {
      logger.severe("Auth result returned nothing");
    }
    return currentUser;
  }

  @override
  Future<CurrentUser> register(
      String email, String password, String name, DateTime dob) async {
    logger.info("Registering");
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await sendConfirmationEmail(result);
    CurrentUser user;
    if (result != null) {
      user = CurrentUser(email: result.user.email, id: result.user.uid);
      await GetIt.instance<DataRepository>()
          .createUser(email, name, result.user.uid, dob);
    }
    return user;
  }

  @override
  Future<void> sendConfirmationEmail(UserCredential user) async {
    await user.user.sendEmailVerification();
  }

  @override
  Future<void> resetPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
