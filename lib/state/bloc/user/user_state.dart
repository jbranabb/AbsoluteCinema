part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}
final class UserLoading extends UserState {}
final class UserLoaded extends UserState {
String username;
UserLoaded({required this.username});
}
final class UserDataLoaded extends UserState{
List<ConvertedModels> dataWatchlist;
List<ConvertedModels> dataFav;
List<ConvertedModels> dataRated;

UserDataLoaded({required this.dataWatchlist, required this.dataFav, required this.dataRated,});
}
final class UserFailed extends UserState {
  String e;
  UserFailed({required this.e});
}
