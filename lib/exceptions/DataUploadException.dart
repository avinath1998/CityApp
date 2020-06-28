class DataUploadException implements Exception {
  final String errorMsg;
  final StackTrace stackTrace;
  DataUploadException(this.errorMsg, this.stackTrace);

  @override
  String toString() {
    return "DATAFETCHEXCEPTION: " + errorMsg;
  }
}
