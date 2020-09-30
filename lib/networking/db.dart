import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:citycollection/exceptions/data_fetch_exception.dart';
import 'package:citycollection/exceptions/data_upload_exception.dart';
import 'package:citycollection/exceptions/no_user_found_exception.dart';
import 'package:citycollection/models/bin_disposal.dart';
import 'package:citycollection/models/current_user.dart';
import 'package:citycollection/models/prize.dart';
import 'package:citycollection/models/redemption.dart';
import 'package:citycollection/models/scan_winnings.dart';
import 'package:citycollection/models/tagged_bin.dart';
import 'package:citycollection/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:logging/logging.dart';

abstract class DB {
  Future<CurrentUser> fetchCurrentUser(String id);
  Future<List<Prize>> fetchPrizes();
  Future<PrizeRedemptionStatus> redeemPrize(Prize prize, CurrentUser user);
  StreamController<TaggedBin> openBinStream();
  void closeBinStream();
  Future<String> uploadWasteImageData(CurrentUser user, Uint8List image);
  Future<void> saveDisposalData(CurrentUser user, String ref);
  Future<ScanWinnings> fetchScanWinnings(CurrentUser user);
  Future<String> uploadBinImageData(CurrentUser user, File image);
  Future<void> saveTaggedBin(CurrentUser user, TaggedBin bin);
  Future<void> createUser(String email, String name, String uid, DateTime dob);
  Future<BinDisposal> saveBinDisposal(
      TaggedBin bin, File wasteImage, File binImage, CurrentUser user);
  Future<void> updateTaggedBin(TaggedBin bin, CurrentUser user);
}

class FirebaseDB extends DB {
  final String TAG = "FIREBASEDB: ";
  final Logger logger = Logger("FirebaseDB");
  StreamSubscription _binStreamSub;
  StreamController<TaggedBin> _binStreamController;

  @override
  Future<CurrentUser> fetchCurrentUser(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    if (doc.exists) {
      Map<String, dynamic> userData = doc.data();
      userData.putIfAbsent("id", () => doc.id);
      CurrentUser user = CurrentUser.fromJson(userData);
      return user;
    } else {
      throw NoUserFoundException("User not found in DB");
    }
  }

  @override
  Future<List<Prize>> fetchPrizes() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("prizes")
        .orderBy("cost")
        .get();
    List<Prize> prizes = List();
    snapshot.docs.forEach((dc) {
      Map<String, dynamic> map = dc.data();
      map["id"] = dc.id;
      Prize prize = Prize.fromJson(map);
      prizes.add(prize);
    });
    return prizes;
  }

  @override
  Future<PrizeRedemptionStatus> redeemPrize(
      Prize prize, CurrentUser user) async {
    CurrentUser fetchedUser = await fetchCurrentUser(user.id);
    Redemption redemption = Redemption(
      userId: user.id,
      cost: prize.cost,
      desc: prize.desc,
      prizeId: prize.id,
      image: prize.image,
      redeemTime: DateTime.now(),
      status: PrizeRedemptionStatus.waiting,
      title: prize.name,
    );
    Map<String, dynamic> map = redemption.toJson();
    map.remove("id");
    if (fetchedUser.points >= prize.cost) {
      await FirebaseFirestore.instance
          .collection("redemptions")
          .add(map); //should be indivudual calls later bro!
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"points": fetchedUser.points - prize.cost});
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
    _binStreamSub = FirebaseFirestore.instance
        .collection("taggedBins")
        .where("active", isEqualTo: true)
        .snapshots()
        .listen((QuerySnapshot snap) {
      snap.docChanges.forEach((docChange) {
        Map<String, dynamic> map = docChange.doc.data();
        map["id"] = docChange.doc.id;
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
  Future<void> saveDisposalData(
      final CurrentUser user, final String photoSrc) async {
    logger.info("Saving Disposal data....");
    DocumentReference ref =
        await FirebaseFirestore.instance.collection("scanDisposals").add({
      "photoSrc": photoSrc,
      "time": DateTime.now().millisecondsSinceEpoch,
      "userId": user.id
    });

    logger.info("Saved Disposal Data");
  }

  @override
  Future<ScanWinnings> fetchScanWinnings(CurrentUser user) async {
    // logger.info("Fetching Scan Winnings");
    // ScanWinnings scanWinnings;
    // Map<String, dynamic> map =
    //     await FirebaseFirestore.instance.runTransaction((Transaction tx) async {
    //   QuerySnapshot snapshot = await FirebaseFirestore.instance
    //       .collection("scanWinnings")
    //       .where("isActive", isEqualTo: true)
    //       .orderBy("additionDate")
    //       .get();

    //   if (snapshot.docs.length > 0) {
    //     DocumentReference docRef = FirebaseFirestore.instance
    //         .collection("scanWinnings")
    //         .doc(snapshot.docs[0].id);

    // DocumentSnapshot docSnap = await tx.get(docRef);
    // if (docSnap.data()["isActive"]) {
    //   await tx.update(
    //       FirebaseFirestore.instance
    //           .collection("scanWinnings")
    //           .document(snapshot.documents[0].documentID),
    //       <String, dynamic>{'isActive': false, "claimedByUserId": user.id});
    //   Map<String, dynamic> snapMap = docSnap.data()();
    //   snapMap["id"] = snapshot.documents[0].documentID;
    //   scanWinnings = ScanWinnings.fromJson(snapMap)
    //       .copyWith(claimedByUserId: user.id, isActive: false);
    // }
    //   }
    // });
    // logger.info(map);
    // logger.info(scanWinnings);
    // return scanWinnings;
  }

  @override
  Future<void> saveTaggedBin(CurrentUser user, TaggedBin bin) async {
    logger.info("Saving Tagged bin");
    Map<String, dynamic> data = bin.toJson();
    data.remove("id");
    try {
      DocumentReference ref =
          await FirebaseFirestore.instance.collection("taggedBins").add(data);
      logger.info("Saved tagged bin information: ${ref.id}");
    } on FirebaseException catch (e, stk) {
      logger.severe(e.message);
      logger.severe(stk);
      throw DataUploadException(
          "Uploading failed", DataUploadExceptionCode.uploadFailed);
    }
  }

  @override
  Future<void> updateTaggedBin(TaggedBin bin, CurrentUser user) async {
    logger.info("Saving Tagged bin");
    Map<String, dynamic> data = bin.toJson();
    data.remove("id");
    try {
      logger.info("Updating: ${bin.id}");
      await FirebaseFirestore.instance
          .collection("taggedBins")
          .doc(bin.id)
          .update(data);
    } on FirebaseException catch (e, stk) {
      logger.severe(e.message);
      logger.severe(stk);
      throw DataUploadException(
          "Uploading failed", DataUploadExceptionCode.uploadFailed);
    }
  }

  @override
  Future<String> uploadBinImageData(CurrentUser user, File image) async {
    try {
      final StorageReference storageReference = FirebaseStorage()
          .ref()
          .child("findmybin")
          .child(user.id)
          .child(DateTime.now().toIso8601String() + ".jpg");
      final StorageUploadTask uploadTask =
          storageReference.putData(image.readAsBytesSync());
      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        logger.info('EVENT ${event.type}');
      });
      await uploadTask.onComplete;
      streamSubscription.cancel();
      if (uploadTask.isSuccessful) {
        logger.info("Successfully saved file");
        String downloadUrl = await storageReference.getDownloadURL();
        return downloadUrl;
      } else {
        throw DataUploadException(
            "Uploading failed", DataUploadExceptionCode.uploadFailed);
      }
    } on FirebaseException catch (e, stk) {
      logger.severe(e.message);
      logger.severe(stk);
      throw DataUploadException(
          "Uploading failed", DataUploadExceptionCode.uploadDenied);
    }
  }

  @override
  Future<void> createUser(
      String email, String name, String uid, DateTime dob) async {
    return await FirebaseFirestore.instance.collection("users").doc(uid).set({
      "email": email,
      "name": name,
      "points": 0,
      "phoneNumber": null,
      "address": null,
      "dob": dob.toIso8601String()
    });
  }

  @override
  Future<BinDisposal> saveBinDisposal(
      TaggedBin bin, File wasteImage, File binImage, CurrentUser user) async {
    final StorageReference storageBinReference = FirebaseStorage()
        .ref()
        .child("binDisposal")
        .child(user.id)
        .child("bin")
        .child(DateTime.now().toIso8601String() + ".jpg");
    final StorageReference storageWasteReference = FirebaseStorage()
        .ref()
        .child("binDisposal")
        .child(user.id)
        .child("waste")
        .child(DateTime.now().toIso8601String() + ".jpg");

    String wasteSrc = await _uploadImage(wasteImage, storageWasteReference);
    String binSrc = await _uploadImage(binImage, storageBinReference);
    BinDisposal disposal = BinDisposal(
      binId: bin.id,
      disposalTime: DateTime.now(),
      userId: user.id,
      pointAmount: 0,
      binImageSrc: binSrc,
      wasteImageSrc: wasteSrc,
      binName: bin.binName,
      status: BinDisposalStatus.pending,
    );
    await FirebaseFirestore.instance
        .collection("binDisposals")
        .add(disposal.toJson());
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot oldBinSnap = await FirebaseFirestore.instance
            .collection("taggedBins")
            .doc(bin.id)
            .get();
        if (oldBinSnap.exists) {
          await FirebaseFirestore.instance
              .collection("taggedBins")
              .doc(bin.id)
              .update(
                  {"disposalsMade": oldBinSnap.data()["disposalsMade"] + 1});
        } else {
          throw FirebaseException(
              message: "No bin found", plugin: "Firestore", code: "001");
        }
      });
      return disposal;
    } on FirebaseException catch (e, stk) {
      logger.severe(e.message);
      logger.severe(stk);
      throw DataUploadException(
          "Uploading failed", DataUploadExceptionCode.uploadFailed);
    }
  }

  Future<String> _uploadImage(
      File image, StorageReference storageReference) async {
    final StorageUploadTask uploadTask =
        storageReference.putData(image.readAsBytesSync());
    await uploadTask.onComplete;
    if (uploadTask.isSuccessful) {
      return await storageReference.getDownloadURL();
    } else {
      throw DataUploadException(
          "Uploading failed", DataUploadExceptionCode.uploadFailed);
    }
  }
}

// FirebaseFirestore.instance.collection("prizes").add({
//   "name": "Dialog 250MB Data Card",
//   "desc": "Dialog 250MB Data Card",
//   "expirationDate": 1577817000000,
//   "remaining": 1,
//   "startDate": 1582830746498,
//   "image":
//       "https://pbs.twimg.com/profile_images/1514269961/Axiata_Tanagram_400x400.jpg",
//   "cost": 300
// });
// FirebaseFirestore.instance.collection("prizes").add({
//   "name": "Mobitel 5000MB Data Card",
//   "desc": "Mobitel 5000MB Data Card",
//   "expirationDate": 1577817000000,
//   "remaining": 1,
//   "startDate": 1582830746498,
//   "image":
//       "https://bizenglish.adaderana.lk/wp-content/uploads/MobitelLogo1.jpg",
//   "cost": 300
// });
// FirebaseFirestore.instance.collection("prizes").add({
//   "name": "Burger King Whopper Meal",
//   "desc": "1 Burger King Whopper meal w/ drink and fries",
//   "expirationDate": 1577817000000,
//   "remaining": 1,
//   "startDate": 1582830746498,
//   "image":
//       "https://media-cdn.tripadvisor.com/media/photo-s/11/0f/6d/9c/burger-king.jpg",
//   "cost": 500
// });
