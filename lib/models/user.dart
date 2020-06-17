abstract class User {
  final String name;
  final int points;
  final UserType userType;
  final String id;

  User({
    this.name,
    this.points,
    this.userType,
    this.id,
  });
}

enum UserType { CurrentUser, NormalUser }
