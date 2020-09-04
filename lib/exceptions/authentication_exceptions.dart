import 'package:freezed_annotation/freezed_annotation.dart';

enum AuthenticationException {
  invalidEmail,
  wrongPassword,
  userNotFound,
  userNotVerified,
  generalAuth,
  fetchFailed,
  userDisabled,
  tooManyRequests,
  operationNotAllowed
}

enum RegistrationException {
  userNotSaved,
  errorWeakPassword,
  invalidEmail,
  emailAreadyInUse,
  generalAuth
}
