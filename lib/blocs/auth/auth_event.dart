part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignInPhoneNumber extends AuthEvent {
  final String phoneNumber;
  SignInPhoneNumber(this.phoneNumber);
}

class AuthCodeEnteredEvent extends AuthEvent {
  final String passcode;
  AuthCodeEnteredEvent(this.passcode);
}

class SignOutEvent extends AuthEvent {}

class CheckIfSignedInEvent extends AuthEvent {}
