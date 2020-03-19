import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/NoUserFoundException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/prize_redemption_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DB {
  Future<CurrentUser> fetchCurrentUser(String id);
  Future<List<Prize>> fetchPrizes();
  Future<PrizeRedemptionStatus> redeemPrize(Prize prize, CurrentUser user);
}

class FirebaseDB extends DB {
  final String TAG = "FIREBASEDB: ";
  @override
  Future<CurrentUser> fetchCurrentUser(String id) async {
    print(TAG + " Fetching Current User");
    DocumentSnapshot doc =
        await Firestore.instance.collection("users").document(id).get();
    if (doc.exists) {
      print(TAG + "Current User Exists");

      CurrentUser user = CurrentUser.fromMap(doc.data, doc.documentID);
      print(user.name);
      return user;
    } else {
      print(TAG + "Current User Does Not Exist in DB");

      throw NoUserFoundException("User not found in DB");
    }
  }

  @override
  Future<List<Prize>> fetchPrizes() async {
    print(TAG + " Fetching Prizes");
    QuerySnapshot snapshot = await Firestore.instance
        .collection("prizes")
        .orderBy("cost")
        .getDocuments();
    print(TAG + " Fetched Prizes");

    List<Prize> prizes = List();
    snapshot.documents.forEach((dc) {
      Prize prize = Prize.fromMap(dc.data, dc.documentID);
      prizes.add(prize);
    });
    print(TAG + " Completed Fetching Prizes");
    return prizes;
  }

  @override
  Future<PrizeRedemptionStatus> redeemPrize(
      Prize prize, CurrentUser user) async {
    CurrentUser fetchedUser = await fetchCurrentUser(user.id);
    if (fetchedUser.points >= prize.cost) {
      DocumentReference ref =
          await Firestore.instance.collection("redemptions").add({
        "cost": prize.cost,
        "desc": prize.desc,
        "status": "WAITING",
        "title": prize.name,
        "userId": user.id,
      });
      await Firestore.instance
          .collection("users")
          .document(user.id)
          .collection("redemptions")
          .add(
        {"redemptionPath": ref, "status": "WAITING"},
      );
      return PrizeRedemptionStatus.WAITING;
    } else {
      print(
          TAG + " Not enough points to make redemption for prize: " + prize.id);
      return PrizeRedemptionStatus.NOT_ENOUGH_POINTS;
    }
  }
}

// Firestore.instance.collection("prizes").add({
//   "name": "Dialog 250MB Data Card",
//   "desc": "Dialog 250MB Data Card",
//   "expirationDate": 1577817000000,
//   "remaining": 1,
//   "startDate": 1582830746498,
//   "image":
//       "https://pbs.twimg.com/profile_images/1514269961/Axiata_Tanagram_400x400.jpg",
//   "cost": 300
// });
// Firestore.instance.collection("prizes").add({
//   "name": "Mobitel 5000MB Data Card",
//   "desc": "Mobitel 5000MB Data Card",
//   "expirationDate": 1577817000000,
//   "remaining": 1,
//   "startDate": 1582830746498,
//   "image":
//       "https://bizenglish.adaderana.lk/wp-content/uploads/MobitelLogo1.jpg",
//   "cost": 300
// });
// Firestore.instance.collection("prizes").add({
//   "name": "Burger King Whopper Meal",
//   "desc": "1 Burger King Whopper meal w/ drink and fries",
//   "expirationDate": 1577817000000,
//   "remaining": 1,
//   "startDate": 1582830746498,
//   "image":
//       "https://media-cdn.tripadvisor.com/media/photo-s/11/0f/6d/9c/burger-king.jpg",
//   "cost": 500
// });
