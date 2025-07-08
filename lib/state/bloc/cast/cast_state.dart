part of 'cast_bloc.dart';

@immutable
sealed class CastState {}

final class CastInitial extends CastState {}
class StateLoading extends CastState{}
class StateLoaded extends CastState{
  List<Cast> cast;
  List<ConvertedModels> recomendations;
  StateLoaded({required this.cast, required this.recomendations});
}
class StateError extends CastState{
  String e;
  StateError({required this.e});
}