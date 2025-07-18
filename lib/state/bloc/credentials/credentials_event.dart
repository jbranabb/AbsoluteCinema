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

class ToggleStatus extends CredentialsEvent {}
