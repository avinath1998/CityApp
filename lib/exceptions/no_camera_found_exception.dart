class NoCameraFoundException implements Exception {
  final String errorMsg;

  NoCameraFoundException(this.errorMsg);

  @override
  String toString() {
    return "NoCameraFoundException: " + errorMsg;
  }
}
