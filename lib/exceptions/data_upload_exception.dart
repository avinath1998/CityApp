class DataUploadException implements Exception {
  final String message;
  final DataUploadExceptionCode code;

  DataUploadException(this.message, this.code);

  @override
  String toString() => 'DataUploadException(message: $message, code: $code)';
}

enum DataUploadExceptionCode { uploadFailed, uploadDenied }
