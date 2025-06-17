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
  List<NowPlayingModel> movieTopRated;
  List<TrendingTvShow> thshows;
  List<AllMovTv> allShows;
  List<InTheatersModel> inTheaters;
  List<StreamingModel> streaming;
  List<UpcomingModel> upcoming;
  StateLoaded({required this.trending,
   required this.movieTopRated, 
   required this.thshows,
   required this.allShows,
   required this.inTheaters,
   required this.streaming,
   required this.upcoming,
   });
}
class NowPlayingState extends HomeState{
List<NowPlayingModel> listnp;
  NowPlayingState({required this.listnp});
}
