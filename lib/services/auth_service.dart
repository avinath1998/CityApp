import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/NoUserFoundException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

abstract class AuthService {
  Future<CurrentUser> signIn(String email, String password);
  Future<CurrentUser> checkIfAlreadySignedIn();
  Future<void> signOut();
  Future<CurrentUser> anonSignIn();
}

class FirebaseAuthService implements AuthService {
  String TAG = "FIREBASEAUTHSERVICE: ";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger logger = Logger("FirebaseAuthService");
  @override
  Future<CurrentUser> signIn(String email, String password) async {
    print(TAG + " Signing in");
    AuthResult result = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((err) {
      print(TAG + " An error has occured signing in.");

      throw NoUserFoundException("Credentials not found!");
    });

    if (result.user == null) {
      throw NoUserFoundException("Credentials not found!");
    } else {
      print(TAG + " User has been Found. ${result.user.uid}");
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
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
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
    AuthResult result = await FirebaseAuth.instance.signInAnonymously();
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
}
