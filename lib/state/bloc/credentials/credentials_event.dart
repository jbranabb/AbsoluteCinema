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

class ToggleStatusWatch extends CredentialsEvent {
  bool? watch;
  ToggleStatusWatch( this.watch);
}
class ToggleStatusFav extends CredentialsEvent {
  bool? fav;
  ToggleStatusFav( this.fav);
}

