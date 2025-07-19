part of 'credentials_bloc.dart';

@immutable
sealed class CredentialsState {}

final class CredentialsInitial extends CredentialsState {}
final class CredentialsStateLoading extends CredentialsState {}
final class StateChecking extends CredentialsState {
  bool watchlist;
  bool fav;
  StateChecking({ required this.watchlist, required this.fav});
}
final class CredentialsStateLoaded extends CredentialsState {
  bool? statusFav;
  bool? statusWatch;
  CredentialsStateLoaded({this.statusWatch, this.statusFav});
}
final class CredentialsStatefailed extends CredentialsState {}