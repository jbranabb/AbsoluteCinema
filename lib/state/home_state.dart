part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class StateLoading extends HomeState {}
class StateLoaded extends HomeState {
  List<MovMovie> list;
  StateLoaded({required this.list});
}
class StateError extends HomeState {
  String e;
  StateError(this.e);
}