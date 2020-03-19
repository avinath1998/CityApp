abstract class User {
  String _name;
  double _points;
  UserType _userType;

  UserType get userType => _userType;

  set userType(UserType userType) {
    _userType = userType;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  double get points => _points;

  set points(double points) {
    _points = points;
  }
}

enum UserType { CurrentUser, NormalUser }
