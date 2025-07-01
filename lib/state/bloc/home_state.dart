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
  List<ConvertedModels> trending;
  List<ConvertedModels> movieTopRated;
  List<ConvertedModels> allShows;
  List<ConvertedModels> inTheaters;
  List<ConvertedModels> streaming;
  List<ConvertedModels> upcoming;
  //tv
  List<ConvertedModels> airingToday;
  List<ConvertedModels> trendingTv;
  List<ConvertedModels> onTheAir;
  List<ConvertedModels> popularTv;
  List<ConvertedModels>  topRatedTv;
  //Converted
  List<ConvertedModels> convertedUpComingMovie;
  StateLoaded({required this.trending,
   required this.movieTopRated, 
   required this.airingToday,
   required this.allShows,
   required this.inTheaters,
   required this.streaming,
   required this.upcoming,
   required this.onTheAir,
   required this.topRatedTv,
   required this.popularTv,
   required this.trendingTv,
   required this.convertedUpComingMovie
   });
}
