import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
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
          .where(
            (e) => e.mediaType == 'movie' || e.mediaType == 'tv',
          )
          .toList();

      List<Future<Map<String, dynamic>>> futureExtras = dataraw.map((mov) {
        final idInt = int.parse(mov.id);
        print('🕵️‍♂️ ID: "${mov.id}" | Tipe: ${mov.id.runtimeType}, | Mediatype = ${mov.mediaType}');
        return extraData(int.parse(mov.id), mov.mediaType);
      }).toList();

      List<Map<String, dynamic>> extras = await Future.wait(futureExtras);
      List<ExtraDataModels> allfinalData = [];
      for (var i = 0; i < dataraw.length; i++) {
        var extra = extras[i];
        var mov = dataraw[i];

        print('🧪 ID: ${mov.id}, Type: ${mov.mediaType}');
        List<String> genreList = mov.genreIds
            .map((id) => genreMapCombaine[id.toString()] ?? 'unknown')
            .toList()
            .cast<String>();

        double rawrate = double.tryParse(mov.voteAvg) ?? 0.0;
        var finalRatings = (rawrate / 10 * 5);
        allfinalData.add(ExtraDataModels(
            id: mov.id,
            genreIds: genreList,
            title: mov.title,
            voteAvg: finalRatings.toString(),
            backdropPath: mov.backdropPath,
            posterPath: mov.posterPath,
            overview: mov.overview,
            mediatype: mov.mediaType,
            relaseDate: mov.relaseDate,
            director: extra['director'],
            runtime: extra['rtns'],
            tagline: extra['tagline']));
      }

      emit(SearchLoaded(searching: allfinalData));
    });
  }
}
