import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'dart:math';
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
          .map((e) => CombaineModels.fromJson(e))
          .where(
            (e) => e.mediaType == 'movie' || e.mediaType == 'tv',
          )
          .toList();

      List<Future<Map<String, dynamic>>> futureExtras = dataraw.map((mov) {
        return externalDirectur(mov.mediaType, mov.id);
      }).toList();

      List<Map<String, dynamic>> extras = await Future.wait(futureExtras);
      int minLength = min(dataraw.length, futureExtras.length);
      print(
          'min: $minLength, data : ${dataraw.length} rx : ${futureExtras.length}');

      List<ExtraDataModels> allfinalData = [];
      for (var i = 0; i < minLength; i++) {
        try {
          var extra = extras[i];
        var mov = dataraw[i];
          String rawdirectur = extra['director']?.toString() ?? 'Unknown';
          String safeDirectur = rawdirectur.isNotEmpty
              ? rawdirectur.replaceAll('<', 'Man').replaceAll('>', 'Man')
              : 'Unknown';
          List<String> genreList = mov.genreIds
              .map((id) => genreMapCombaine[id.toString()] ?? 'unknown')
              .toList()
              .cast<String>();
          double rawrate = double.tryParse(mov.voteAvg) ?? 0.0;
          var finalRatings = (rawrate / 10 * 5);
         var checkRelaseDate =  mov.relaseDate != '' ? mov.relaseDate : '2001-11-16';
          allfinalData.add(ExtraDataModels(
              id: mov.id,
              genreIds: genreList,
              title: mov.title,
              voteAvg: finalRatings.toString(),
              backdropPath: mov.backdropPath,
              posterPath: mov.posterPath,
              overview: mov.overview,
              mediatype: mov.mediaType,
              relaseDate: checkRelaseDate,
              director: extra['director']));
        } catch (e) {
          print('Somengthing went bad broo $e');
        }
      }
      emit(SearchLoaded(searching: allfinalData));
    });
    on<Reset>((event, emit) {
      if(state is! SearchInitial){
      emit(SearchInitial());
      }
    });
  }
}
