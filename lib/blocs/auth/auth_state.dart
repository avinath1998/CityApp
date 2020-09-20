part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial();
}

class SignedInState extends AuthState {
  final CurrentUser user;
  SignedInState(this.user);
}

class SignedOutState extends AuthState {}

class SigningInWaitingState extends AuthState {}

class SignInFailedState extends AuthState {
  final String errorMsg;
  final AuthenticationException exception;
  SignInFailedState(this.errorMsg, this.exception);
}

class RegistrationWaitingState extends AuthState {}

class RegistrationSuccessfulState extends AuthState {
  final CurrentUser user;

  RegistrationSuccessfulState(this.user);
}

class RegistrationFailedState extends AuthState {
  final String errorMsg;
  final RegistrationException exception;

  RegistrationFailedState(this.errorMsg, this.exception);
}

class AuthUpdatedState extends AuthState {
  final CurrentUser user;

  AuthUpdatedState(this.user);
}

class AuthUpdateFailedState extends AuthState {
  final Exception exception;

  AuthUpdateFailedState(this.exception);
}
