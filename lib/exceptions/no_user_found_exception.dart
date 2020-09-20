class NoUserFoundException implements Exception {
  final String errorMsg;

  NoUserFoundException(this.errorMsg);
}
