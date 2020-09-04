class UserNotVerifiedException implements Exception {
  final String errorMsg;

  UserNotVerifiedException(this.errorMsg);

  @override
  String toString() {
    return "UserNotVerifiedException: " + errorMsg;
  }
}
