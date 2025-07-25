part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}
class Searching extends SearchEvent {
  String querySeacrhing;
  Searching({required this.querySeacrhing});
}

class RecomendationByGenres extends SearchEvent {
  int genresId;
  RecomendationByGenres({required this.genresId});
}

class Reset extends SearchEvent {}