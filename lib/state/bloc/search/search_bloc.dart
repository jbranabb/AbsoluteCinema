import 'package:absolutecinema/apiService/model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    var apiKey = dotenv.env['API_KEY'];
    Dio dio = Dio();
    on<Searching>((event, emit) async {
    emit(SearchLoading());
      String genreUrlMov =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';
      String genreUrlTv =
          'https://api.themoviedb.org/3/genre/tv/list?api_key=$apiKey';
      String multiSearchUrl =
          'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=${event.querySeacrhing}';

      late Map<String, dynamic> genreMapCombaine = {};
      var responseGenreMov = await dio.get(genreUrlMov);
      var responseGenreTv = await dio.get(genreUrlTv);
      var genretv = responseGenreTv.data['genres'];
      var genremov = responseGenreMov.data['genres'];

      genreMapCombaine = {
        for (var g in genretv) g['id'].toString(): g['name'],
        for (var g in genremov) g['id'].toString(): g['name']
      };

      var response = await dio.get(multiSearchUrl);
      List<dynamic> results = response.data['results'];
      List<CombaineModels> dataraw = results
          .map(
            (e) => CombaineModels.fromJson(e),
          )
          .toList();
      List<ConvertedModels> finalData = dataraw.map(
        (mov) {
          List<String> genreList = mov.genreIds
              .map(
                (id) => genreMapCombaine[id.toString()] ?? 'unknown',
              )
              .toList()
              .cast<String>();
          double rawrate = double.parse(mov.voteAvg);
          var finalRatings = (rawrate / 10 * 5);
          return ConvertedModels(
              id: mov.id,
              genreIds: genreList,
              title: mov.title,
              voteAvg: finalRatings.toString(),
              backdropPath: mov.backdropPath,
              posterPath: mov.posterPath,
              overview: mov.overview,
              mediatype: mov.mediaType,
              relaseDate: mov.relaseDate);
        },
      ).toList();
      emit(SearchLoaded(searching: finalData));
    });
  }
}
