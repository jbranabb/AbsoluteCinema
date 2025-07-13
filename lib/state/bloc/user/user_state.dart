part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class UserLoading extends UserState {}
final class UserLoaded extends UserState {
String username;
UserLoaded({required this.username});
}
final class UserFailed extends UserState {
  String e;
  UserFailed({required this.e});
}
