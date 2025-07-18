part of 'credentials_bloc.dart';

@immutable
sealed class CredentialsState {}

final class CredentialsInitial extends CredentialsState {}
final class CredentialsStateLoading extends CredentialsState {}
final class StateChecking extends CredentialsState {
  bool watchlist;
  bool fav;
  bool rated;
  StateChecking({ required this.watchlist, required this.rated, required this.fav});
}
final class CredentialsStateLoaded extends CredentialsState {}
final class CredentialsStatefailed extends CredentialsState {}