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

class ToggleStatus extends CredentialsEvent {
  bool? fav;
  bool? watch;
  ToggleStatus(this.watch, this.fav);
}

