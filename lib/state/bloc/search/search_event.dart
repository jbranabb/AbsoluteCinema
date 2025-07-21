part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}
class Searching extends SearchEvent {
  String querySeacrhing;
  Searching({required this.querySeacrhing});
}