part of 'data_user_bloc.dart';

@immutable
sealed class DataUserState {}

final class DataUserInitial extends DataUserState {}
final class DataUserLoading extends DataUserState {}
final class DataUserLoaded extends DataUserState {
  String username;
  String profilePath;
  DataUserLoaded({required this.username, required this.profilePath});
}
final class DataUserFailed extends DataUserState {
  String? e;
  DataUserFailed(this.e,);
}