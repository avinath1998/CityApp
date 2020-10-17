import 'package:citycollection/models/notifications/add_bin_notification/add_bin_notification.dart';
import 'package:citycollection/models/notifications/base_notification.dart';
import 'package:citycollection/models/notifications/disposal_notification/disposal_notification.dart';
import 'package:citycollection/models/notifications/general_notification/general_notification.dart';
import 'package:citycollection/models/notifications/prize_notification/prize_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

class PushNotificationsManager {
  PushNotificationsManager._({this.onInitialized});

  factory PushNotificationsManager({Function onInitialized}) => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;
  final Function onInitialized;
  List<Function(BaseNotification map)> callbacks = List();

  final Logger logger = Logger("PushNotificationsManager");
  void addCallback(Function(BaseNotification notification) callback) {
    callbacks.add(callback);
  }

  void clearCallbacks() {
    callbacks.clear();
  }

  Future<void> init({bool askedOnce = false}) async {
    if (!_initialized) {
      if (await _firebaseMessaging.requestNotificationPermissions()) {
        callbacks = List();
        // For testing purposes print the Firebase Messaging token
        String token = await _firebaseMessaging.getToken();
        print("FirebaseMessaging token: $token");
        _initialized = true;
        _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
            Map<String, dynamic> map = {};
            logger.info(message);
            map.addAll(Map.from(message["notification"]));
            map.addAll(Map.from(message["data"]));
            BaseNotification notif;
            switch (message["data"]["type"]) {
              case "prize":
                notif = PrizeNotification.fromJson(map);
                break;
              case "disposal":
                notif = DisposalNotification.fromJson(map);
                break;
              case "general":
                notif = GeneralNotification.fromJson(map);
                break;
              case "addBin":
                notif = AddBinNotification.fromJson(map);
                break;
            }
            callbacks.forEach((element) {
              element(notif);
            });
          },
          onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
          },
          onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
          },
        );
      }
    }
  }
}
