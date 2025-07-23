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
  int mediaId;
  String mediaType;
  bool? watch;
  ToggleStatusWatch(this.mediaId, this.mediaType, this.watch);
}
class ToggleStatusFav extends CredentialsEvent {
  int mediaId;
  String mediaType;
  bool? fav;
  ToggleStatusFav( this.mediaId, this.mediaType, this.fav);
}
class PostRatings extends CredentialsEvent {
    int mediaId;
  String mediaType;
  double value;
  PostRatings({required this.mediaId,  required this.mediaType, required this.value});
}
