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
  void saveDisposalData(CurrentUser user, String ref);
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
        await Firestore.instance.collection("users").document(id).get();
    if (doc.exists) {
      Map<String, dynamic> userData = doc.data;
      userData.putIfAbsent("id", () => doc.documentID);
      CurrentUser user = CurrentUser.fromJson(userData);
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
      await Firestore.instance
          .collection("redemptions")
          .add(map); //should be indivudual calls later bro!
      await Firestore.instance
          .collection("users")
          .document(user.id)
          .updateData({"points": fetchedUser.points - prize.cost});
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
  void saveDisposalData(final CurrentUser user, final String photoSrc) async {
    logger.info("Saving Disposal data....");
    DocumentReference ref =
        await Firestore.instance.collection("scanDisposals").add({
      "photoSrc": photoSrc,
      "time": DateTime.now().millisecondsSinceEpoch,
      "userId": user.id
    });

    logger.info("Saved Disposal Data");
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
  Future<void> saveTaggedBin(CurrentUser user, TaggedBin bin) async {
    logger.info("Saving Tagged bin");
    Map<String, dynamic> data = bin.toJson();
    data.remove("id");
    DocumentReference ref =
        await Firestore.instance.collection("taggedBins").add(data);
    logger.info("Saved tagged bin information: ${ref.documentID}");
  }

  @override
  Future<void> updateTaggedBin(TaggedBin bin, CurrentUser user) async {
    logger.info("Saving Tagged bin");
    Map<String, dynamic> data = bin.toJson();
    data.remove("id");

    await Firestore.instance
        .collection("taggedBins")
        .document(bin.id)
        .updateData(data);
  }

  @override
  Future<String> uploadBinImageData(CurrentUser user, File image) async {
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
    logger.info("Successfully saved file");
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> createUser(
      String email, String name, String uid, DateTime dob) async {
    return await Firestore.instance.collection("users").document(uid).setData({
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
      userId: user.id,
      binImageSrc: binSrc,
      wasteImageSrc: wasteSrc,
      status: BinDisposalStatus.pending,
    );
    await Firestore.instance.collection("binDisposals").add(disposal.toJson());

    return disposal;
  }

  Future<String> _uploadImage(
      File image, StorageReference storageReference) async {
    final StorageUploadTask uploadTask =
        storageReference.putData(image.readAsBytesSync());
    await uploadTask.onComplete;
    if (uploadTask.isSuccessful) {
      return await storageReference.getDownloadURL();
    } else {
      throw DataUploadException("Image not uploaded", StackTrace.current);
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
