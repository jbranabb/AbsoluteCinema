part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}
final class SearchLoaded extends SearchState {
  List<ExtraDataModels> searching;
  SearchLoaded({required this.searching});
}
final class SearchLoadedRecGen extends SearchState {
  List<ExtraDataModels> searchingRec;
  SearchLoadedRecGen({required this.searchingRec});
}
final class SearchError extends SearchState {}
