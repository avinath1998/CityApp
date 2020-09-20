class DataFetchException implements Exception {
  final String errorMsg;

  DataFetchException(this.errorMsg);

  @override
  String toString() {
    return "DATAFETCHEXCEPTION: " + errorMsg;
  }
}
