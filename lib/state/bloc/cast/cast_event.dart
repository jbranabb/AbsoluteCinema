part of 'cast_bloc.dart';

@immutable
sealed class CastEvent {}
class FetchCast extends CastEvent{
  int id;
  String mediaType;
  FetchCast({required this.id, required this.mediaType});
}
class RestoreCast extends CastEvent {}
