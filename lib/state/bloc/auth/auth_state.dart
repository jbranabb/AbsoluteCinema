part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}

final class AuthLoaded extends AuthState {
  String url;
  String token;
  AuthLoaded({required this.url, required this.token});
}
final class AuthSucces extends AuthState{
  String sessionId;
   AuthSucces({required this.sessionId});
}
final class AuthFailed extends AuthState {
  String e;
  AuthFailed({required this.e});
}
