part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetSessionUser extends UserEvent {
  String sesionId;
  GetSessionUser({required this.sesionId});
}

class UserCredentials extends UserEvent{
  String mediaType;
  UserCredentials({required this.mediaType});
}