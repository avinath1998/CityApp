class DataFetchException implements Exception {
  final String errorMsg;

  DataFetchException(this.errorMsg);

  @override
  String toString() => 'DataFetchException(errorMsg: $errorMsg)';
}

enum DataFetchExceptionCode { uploadFailed, uploadDenied }
