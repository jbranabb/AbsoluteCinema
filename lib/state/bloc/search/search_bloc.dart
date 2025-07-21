import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    var apikey = dotenv.env['API_KEY'];
    Dio dio = Dio();
    on<Searching>((event, emit)async {
      String multiSearchUrl =
          'https://api.themoviedb.org/3/search/multi$apikey';
  var response = await dio.get(multiSearchUrl);
    
    });
  }
}
