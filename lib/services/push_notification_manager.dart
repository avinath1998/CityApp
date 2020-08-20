import 'package:logging/logging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;
  List<Function(Map<String, dynamic> map)> callbacks;
  final Logger logger = Logger("PushNotificationsManager");
  void addCallback(Function(Map<String, dynamic>) callback) {
    callbacks.add(callback);
  }

  void clearCallbacks() {
    callbacks.clear();
  }

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      // _firebaseMessaging.requestNotificationPermissions();
      // _firebaseMessaging.configure();
      //   callbacks = List();
      //   // For testing purposes print the Firebase Messaging token
      //   String token = await _firebaseMessaging.getToken();
      //   print("FirebaseMessaging token: $token");

      //   _initialized = true;
      // }
      // _firebaseMessaging.configure(
      //   onMessage: (Map<String, dynamic> message) async {
      //     print("onMessage: $message");
      //     logger.info(callbacks.length);
      //     callbacks.forEach((element) {
      //       logger.info("Calling back");
      //       element(message);
      //     });
      //   },
      //   onLaunch: (Map<String, dynamic> message) async {
      //     print("onLaunch: $message");
      //   },
      //   onResume: (Map<String, dynamic> message) async {
      //     print("onResume: $message");
      //   },
      // );
    }
  }
}
