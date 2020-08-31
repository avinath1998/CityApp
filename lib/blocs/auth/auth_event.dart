part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

class CheckIfSignedInEvent extends AuthEvent {}

class RegisterUserEvent extends AuthEvent {
  final CurrentUser user;
  final String password;
  RegisterUserEvent(this.user, this.password);
}
