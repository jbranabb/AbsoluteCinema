part of 'cast_bloc.dart';

@immutable
sealed class CastState {}

final class CastInitial extends CastState {}
class StateLoading extends CastState{}
class StateLoaded extends CastState{
  List<Cast> cast;
  StateLoaded({required this.cast});
}
class StateError extends CastState{
  String e;
  StateError({required this.e});
}