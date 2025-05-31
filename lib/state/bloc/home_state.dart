part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class StateLoading extends HomeState {}
class StateError extends HomeState {
  String e;
  StateError(this.e);
}
class StateLoaded extends HomeState {
  List<TrendingThisWeekModel> trending;
  List<NowPlayingModel> nowplaying;
  List<TrendingTvShow> thshows;
  StateLoaded({required this.trending,
   required this.nowplaying, 
   required this.thshows
   });
}
class NowPlayingState extends HomeState{
List<NowPlayingModel> listnp;
  NowPlayingState({required this.listnp});
}
