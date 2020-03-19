import 'package:citycollection/models/collection_trip.dart';
import 'package:citycollection/models/disposal.dart';
import 'package:citycollection/models/redemption.dart';
import 'package:citycollection/models/user.dart';

class CurrentUser extends User {
  String _address;
  DateTime _dob;
  List<CollectionTrip> _collectionTrips;
  List<Disposal> _disposals;
  List<Redemption> _redemptions;
  String _id;

  static CurrentUser fromMap(Map<String, dynamic> map, String id) {
    CurrentUser user = new CurrentUser();
    user.name = map['name'].toString();
    user.points = map['points'] as double;
    user.userType = UserType.CurrentUser;
    user.id = id;
    return user;

    //user.collectionTrips = map['collectionTrips'];
    //user.disposals = map['disposals'];
    //user.redemptions = map['redemptions'];
    //user.dob = map['dob']
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }

  String get address => _address;

  set address(String address) {
    _address = address;
  }

  DateTime get dob => _dob;

  set dob(DateTime dob) {
    _dob = dob;
  }

  List<CollectionTrip> get collectionTrips => _collectionTrips;

  set collectionTrips(List<CollectionTrip> collectionTrips) {
    _collectionTrips = collectionTrips;
  }

  List<Disposal> get disposals => _disposals;

  set disposals(List<Disposal> disposals) {
    _disposals = disposals;
  }

  List<Redemption> get redemptions => _redemptions;

  set redemptions(List<Redemption> redemptions) {
    _redemptions = redemptions;
  }
}
