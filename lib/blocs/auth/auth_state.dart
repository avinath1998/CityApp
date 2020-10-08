part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  AuthInitial();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignedInState extends AuthState {
  final CurrentUser user;
  SignedInState(this.user);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignedOutState extends AuthState {
  @override
  List<Object> get props => [];
}

class SigningInWaitingState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignInFailedState extends AuthState {
  final String errorMsg;
  final AuthenticationException exception;
  SignInFailedState(this.errorMsg, this.exception);

  @override
  List<Object> get props => [];
}

class RegistrationWaitingState extends AuthState {
  @override
  List<Object> get props => [];
}

class RegistrationSuccessfulState extends AuthState {
  final CurrentUser user;

  RegistrationSuccessfulState(this.user);

  @override
  List<Object> get props => throw UnimplementedError();
}

class RegistrationFailedState extends AuthState {
  final String errorMsg;
  final RegistrationException exception;

  RegistrationFailedState(this.errorMsg, this.exception);

  @override
  List<Object> get props => [];
}

class ForgetPasswordSendingState extends AuthState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordSentState extends AuthState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordFailedSendingState extends AuthState {
  final AuthenticationException exception;

  ForgetPasswordFailedSendingState(this.exception);

  @override
  List<Object> get props => [exception];
}

class AuthUpdatedState extends AuthState {
  final CurrentUser user;

  AuthUpdatedState(this.user);

  @override
  List<Object> get props => [];
}

class AuthUpdateFailedState extends AuthState {
  final Exception exception;

  AuthUpdateFailedState(this.exception);

  @override
  List<Object> get props => [];
}
