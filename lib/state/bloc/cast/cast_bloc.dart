import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'cast_event.dart';
part 'cast_state.dart';

Dio dio = Dio();

class CastBloc extends Bloc<CastEvent, CastState> {
  CastBloc() : super(CastInitial()) {
    on<FetchCast>((event, emit) async {
      emit(StateLoading());
      String castUrl ='https://api.themoviedb.org/3/${event.mediaType}/${event.id}/credits?api_key=$imdbKey';
      String recomendationUrl ='https://api.themoviedb.org/3/${event.mediaType}/${event.id}/recommendations?api_key=$imdbKey';
          print(recomendationUrl);
      final response = await dio.get(castUrl);
          final responsRec = await dio.get(recomendationUrl);
           Map<String, dynamic> genreMapCombaine = {};
          var responseGenre = await dio.get(genreUrlMov);
          var responseGenreMapTv = await dio.get(genreUrlTv);
          List genre = responseGenre.data['genres'];
          List genreTv = responseGenreMapTv.data['genres'];
          genreMapCombaine = {
            for(var x in genreTv) x['id'].toString() : x['name'],
            for(var x in genre) x['id'].toString() : x['name']
          };
      if (response.statusCode == 200) {
        try {
          List<dynamic> data = response.data['cast'];
          print('data : $data');
          List<Cast> datacast = data
              .map(
                (e) => Cast.fromJson(e),
              )
              .take(5)
              .toList();
              print('datacast: $datacast');

            List<dynamic> dataRec = responsRec.data['results'];
            List<CombaineModels> dataMap = dataRec.map((e) => CombaineModels.fromJson(e),).toList();
            List<ConvertedModels> finalData = dataMap.map((mov) {
            List<String> genreList = mov.genreIds.map((e) =>  genreMapCombaine[e.toString()],).toList().cast<String>();
             var ratings = double.parse(mov.voteAvg);
             var finalratings = (ratings / 10 * 5);
             return ConvertedModels(id: mov.id, genreIds:
               genreList, title: mov.title, voteAvg: finalratings.toString(), backdropPath: 
               mov.backdropPath, posterPath: mov.posterPath, overview: mov.overview, 
               mediatype: event.mediaType, relaseDate: mov.relaseDate);
            }).toList();
          emit(StateLoaded(cast: datacast,
          recomendations: finalData ,
          ));
        } catch (e) {
          emit(StateError(e: e.toString()));
          print(e);
        }
      } else {
        emit(StateError(e: 'Terjadi Kesalahan'));
      }
    });
  }
}
