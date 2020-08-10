import 'dart:async';
import 'dart:typed_data';

import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/exceptions/NoUserFoundException.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:logging/logging.dart';

abstract class DB {
  Future<CurrentUser> fetchCurrentUser(String id);
  Future<List<Prize>> fetchPrizes();
  Future<PrizeRedemptionStatus> redeemPrize(Prize prize, CurrentUser user);
  StreamController<TaggedBin> openBinStream();
  void closeBinStream();
  Future<String> uploadWasteImageData(CurrentUser user, Uint8List image);
  Future<String> uploadBinImageData(CurrentUser user, Uint8List image);
  Future<String> saveDisposalData(CurrentUser user, String binImageRef,
      String wasteItemRef, ScanWinnings scanWinningsId, String phoneNumber);
  Future<ScanWinnings> fetchScanWinnings(CurrentUser user);
  Future<void> savePhoneNumberForWinnings(
      CurrentUser user, String phoneNumber, String disposalId);
}

class FirebaseDB extends DB {
  final String TAG = "FIREBASEDB: ";
  final Logger logger = Logger("FirebaseDB");
  StreamSubscription _binStreamSub;
  StreamController<TaggedBin> _binStreamController;

  @override
  Future<CurrentUser> fetchCurrentUser(String id) async {
    DocumentSnapshot doc =
        await Firestore.instance.collection("users").document(id).get();
    if (doc.exists) {
      Map<String, dynamic> userData = doc.data;
      userData.putIfAbsent("id", () => doc.documentID);
      userData.putIfAbsent("userType", () => UserType.CurrentUser);
      logger.info(userData);
      CurrentUser user = CurrentUser.fromJson(userData);
      logger.info(doc.data);
      return user;
    } else {
      throw NoUserFoundException("User not found in DB");
    }
  }

  @override
  Future<List<Prize>> fetchPrizes() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("prizes")
        .orderBy("cost")
        .getDocuments();
    List<Prize> prizes = List();
    snapshot.documents.forEach((dc) {
      Map<String, dynamic> map = dc.data;
      map["id"] = dc.documentID;
      Prize prize = Prize.fromJson(map);
      prizes.add(prize);
    });
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
      return PrizeRedemptionStatus.waiting;
    } else {
      print(
          TAG + " Not enough points to make redemption for prize: " + prize.id);
      return PrizeRedemptionStatus.notEnoughPoints;
    }
  }

  @override
  StreamController<TaggedBin> openBinStream() {
    _binStreamController = StreamController();
    logger.info("Opening bin stream");
    _binStreamSub = Firestore.instance
        .collection("taggedBins")
        .snapshots()
        .listen((QuerySnapshot snap) {
      snap.documentChanges.forEach((docChange) {
        Map<String, dynamic> map = docChange.document.data;
        map["id"] = docChange.document.documentID;
        TaggedBin bin = TaggedBin.fromJson(map);
        _binStreamController.add(bin);
      });
    });
    return _binStreamController;
  }

  @override
  void closeBinStream() {
    _binStreamSub?.cancel();
    _binStreamController?.close();
  }

  @override
  Future<String> uploadWasteImageData(CurrentUser user, Uint8List image) async {
    final StorageReference storageReference = FirebaseStorage()
        .ref()
        .child("cityscan")
        .child(user.id)
        .child("wasteItems")
        .child(DateTime.now().toIso8601String() + ".jpg");
    final StorageUploadTask uploadTask = storageReference.putData(image);
    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      logger.info('EVENT ${event.type}');
    });
    await uploadTask.onComplete;
    streamSubscription.cancel();
    logger.info("Successfully saved file");
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<String> uploadBinImageData(CurrentUser user, Uint8List image) async {
    final StorageReference storageReference = FirebaseStorage()
        .ref()
        .child("cityscan")
        .child(user.id)
        .child("bins")
        .child(DateTime.now().toIso8601String() + ".jpg");
    final StorageUploadTask uploadTask = storageReference.putData(image);
    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      logger.info('EVENT ${event.type}');
    });
    await uploadTask.onComplete;
    streamSubscription.cancel();
    logger.info("Successfully saved file");
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<String> saveDisposalData(
      final CurrentUser user,
      final String binImage,
      final String wasteImage,
      final ScanWinnings scanWinnings,
      final String phoneNumber) async {
    logger.info("Saving Disposal data....");
    DocumentReference ref =
        await Firestore.instance.collection("scanDisposals").add({
      "binImage": binImage,
      "wasteImage": wasteImage,
      "time": DateTime.now().millisecondsSinceEpoch,
      "userId": user.id,
      "scanWinningsId": scanWinnings != null ? scanWinnings.id : null,
      "phoneNumber": phoneNumber
    });
    return ref.documentID;
  }

  @override
  Future<ScanWinnings> fetchScanWinnings(CurrentUser user) async {
    logger.info("Fetching Scan Winnings");
    ScanWinnings scanWinnings;
    Map<String, dynamic> map =
        await Firestore.instance.runTransaction((Transaction tx) async {
      QuerySnapshot snapshot = await Firestore.instance
          .collection("scanWinnings")
          .where("isActive", isEqualTo: true)
          .orderBy("additionDate")
          .getDocuments();

      if (snapshot.documents.length > 0) {
        DocumentReference docRef = Firestore.instance
            .collection("scanWinnings")
            .document(snapshot.documents[0].documentID);

        DocumentSnapshot docSnap = await tx.get(docRef);
        if (docSnap["isActive"]) {
          await tx.update(
              Firestore.instance
                  .collection("scanWinnings")
                  .document(snapshot.documents[0].documentID),
              <String, dynamic>{'isActive': false, "claimedByUserId": user.id});
          Map<String, dynamic> snapMap = docSnap.data;
          snapMap["id"] = snapshot.documents[0].documentID;
          scanWinnings = ScanWinnings.fromJson(snapMap)
              .copyWith(claimedByUserId: user.id, isActive: false);
        }
      }
    });
    logger.info(map);
    logger.info(scanWinnings);
    return scanWinnings;
  }

  @override
  Future<void> savePhoneNumberForWinnings(
      CurrentUser user, String phoneNumber, String disposalId) async {
    logger.info("Saving Phone number in database");
    logger.info("Disposal ID: $disposalId");
    await Firestore.instance
        .collection("scanDisposals")
        .document(disposalId)
        .updateData({"phoneNumber": phoneNumber});
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
