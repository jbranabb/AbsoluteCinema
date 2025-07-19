part of 'credentials_bloc.dart';

@immutable
sealed class CredentialsEvent {}

class CheckStatus extends CredentialsEvent {
  String mediaType;
  int mediaId;
  BuildContext ctx;
  CheckStatus({
    required this.mediaId,
    required this.mediaType,
    required this.ctx,
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
