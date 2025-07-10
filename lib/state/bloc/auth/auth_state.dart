part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoaded extends AuthState {
  String url;
  AuthLoaded(this.url);
}
final class AuthError extends AuthState {
  String e;
  AuthError({required this.e});
}
