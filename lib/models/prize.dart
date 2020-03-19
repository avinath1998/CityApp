import 'package:equatable/equatable.dart';

class Prize extends Equatable {
  String _desc;
  String _image;
  int _remaining;
  DateTime _expirationDate;
  String _name;
  String _id;
  int _cost;
  String _type;

  static Prize fromMap(Map<String, dynamic> map, String id) {
    Prize prize = Prize();
    prize.desc = map['desc'];
    prize.image = map['image'];
    prize.remaining = map['remaining'];
    prize.name = map['name'];
    prize.cost = map['cost'];
    prize.type = map['type'];
    prize.id = id;
    prize.expirationDate =
        DateTime.fromMillisecondsSinceEpoch(map['expirationDate']);
    return prize;
  }

  String get type => _type;

  set type(String type) {
    _type = type;
  }

  int get cost => _cost;

  set cost(int cost) {
    _cost = cost;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get desc => _desc;

  set desc(String desc) {
    _desc = desc;
  }

  String get image => _image;

  set image(String image) {
    _image = image;
  }

  int get remaining => _remaining;

  set remaining(int remaining) {
    _remaining = remaining;
  }

  DateTime get expirationDate => _expirationDate;

  set expirationDate(DateTime expirationDate) {
    _expirationDate = expirationDate;
  }

  @override
  List<Object> get props => [id];
}
