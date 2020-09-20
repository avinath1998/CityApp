class LocationUpdateException implements Exception {
  final String errorMsg;

  LocationUpdateException(this.errorMsg);

  @override
  String toString() {
    return "LocationUpdateException: " + errorMsg;
  }
}
