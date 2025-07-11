part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class AuthRequestToken extends AuthEvent{}
class AuthExchangeToken extends AuthEvent{
  String token;
  AuthExchangeToken({required this.token});
}
class AuthDenied extends AuthEvent{}