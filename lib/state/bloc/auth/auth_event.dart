part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class Authentication extends AuthEvent{}