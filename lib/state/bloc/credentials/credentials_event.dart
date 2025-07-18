part of 'credentials_bloc.dart';

@immutable
sealed class CredentialsEvent {}

class CheckStatus extends CredentialsEvent {
  String mediaType;
  int mediaId;
  CheckStatus({
    required this.mediaId,
    required this.mediaType,
  });
}

class ToggleStatusFav extends CredentialsEvent {
  bool fav;
  ToggleStatusFav({required this.fav});
}
class ToggleStatusWatchlist extends CredentialsEvent {
  bool watch;
  ToggleStatusWatchlist({required this.watch});
}
