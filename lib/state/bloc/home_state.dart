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
  List<AllMovTv> allShows;
  List<InTheatersModel> inTheaters;
  List<StreamingModel> streaming;
  List<UpcomingModel> upcoming;
  //tv
  List<AiringTvShowsModel> airingToday;
  List<TrendingTvModel> trendingTv;
  List<OnTheAirModel> onTheAir;
  List<PopularTVModel> popularTv;
  List<TopRatedTV>  topRated;
  StateLoaded({required this.trending,
   required this.movieTopRated, 
   required this.airingToday,
   required this.allShows,
   required this.inTheaters,
   required this.streaming,
   required this.upcoming,
   required this.onTheAir,
   required this.topRated,
   required this.popularTv,
   required this.trendingTv,
   });
}
class NowPlayingState extends HomeState{
List<NowPlayingModel> listnp;
  NowPlayingState({required this.listnp});
}
