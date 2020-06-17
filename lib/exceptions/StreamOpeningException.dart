class StreamOpeningException implements Exception {
  final String errorMsg;

  StreamOpeningException(this.errorMsg);

  @override
  String toString() {
    return "StreamOpeningException: " + errorMsg;
  }
}
