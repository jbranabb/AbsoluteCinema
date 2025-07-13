part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetSessionUser extends UserEvent {
  String sesionId;
  GetSessionUser({required this.sesionId});
}
class UserData extends UserEvent {}