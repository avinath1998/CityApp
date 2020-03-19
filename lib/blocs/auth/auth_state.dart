part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignedInState extends AuthState {
  final CurrentUser user;
  SignedInState(this.user);
}

class SignedOutState extends AuthState {}

class SigningInWaitingState extends AuthState {}

class SignInFailedState extends AuthState {
  final String errorMsg;

  SignInFailedState(this.errorMsg);
}
