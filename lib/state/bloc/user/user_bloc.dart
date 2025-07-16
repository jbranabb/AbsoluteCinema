import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    Dio dio = Dio();
    on<GetSessionUser>((event, emit) async {
      emit(UserLoading());
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      // handle terima event dari authbloc
      String accountUrl =
          'https://api.themoviedb.org/3/account?session_id=${event.sesionId}&api_key=$imdbKey';
      final response = await dio.get(accountUrl);
      try {
        if (response.statusCode == 200) {
          print('Succes : True');
          print("response : ${response.data}");
          // save the reponse data to the sharedprefrences
          _prefs.setString('sessionId', event.sesionId);
          _prefs.setString(
              'username', response.data['username'] ?? 'invalid username');
          int id = response.data['id'];
          _prefs.setInt('id', id);
        } else {
          emit(UserFailed(e: response.statusCode.toString()));
        }
      } catch (e) {
        emit(UserFailed(e: e.toString()));
      }
    });
    on<UserData>((event, emit) async {
      emit(UserLoading());
      var id = pref?.getInt('id');
      var username = pref?.getString('username');
      emit(UserLoaded(username: username!));
    });
    on<UserCredentials>((event, emit) async {
      emit(UserLoading());
      var id = pref?.getInt('id');
      var sesionId = pref?.getString('sessionId');
      var usrname = pref?.getString('username');
      var headers = '?session_id=$sesionId&api_key=$imdbKey';
      if (
          // pref == null
          // ||
          id == null || sesionId == null) {
        emit(UserFailed(e: 'Failed $id, failed $usrname'));
      }
      //get fav
      String favUrl =
          'https://api.themoviedb.org/3/account/$id/favorite/${event.mediaType}$headers';
      //get watchlist
      String watchlistUrl =
          'https://api.themoviedb.org/3/account/$id/watchlist/${event.mediaType}$headers';

      String genreUrlMov =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=$imdbKey';
      String genreUrlTv =
          'https://api.themoviedb.org/3/genre/tv/list?api_key=$imdbKey';

      var responseFAv = await dio.get(favUrl);
      var responseWatchUrl = await dio.get(watchlistUrl);



      Map<String, dynamic> genreMapCombaine = {};
      var responseGenreTv = await dio.get(genreUrlTv);
      var responseGenreMov = await dio.get(genreUrlMov);
      List dataGenreMov = responseGenreMov.data['genres'];
      List dataGenreTv = responseGenreTv.data['genres'];
      genreMapCombaine = {
        for (var g in dataGenreTv) g['id'].toString(): g['name'],
        for (var g in dataGenreMov) g['id'].toString(): g['name']
      };
      // print('genremap combaine : $genreMapCombaine');



      
      if (responseFAv.statusCode == 200 && responseWatchUrl.statusCode == 200) {
        List<dynamic> datafav = responseFAv.data['results'];
        List<dynamic> dataWatchlist = responseWatchUrl.data['results'];

        final List<CombaineModels> rawDataFav =
            datafav.map((e) => CombaineModels.fromJson(e)).toList();
        List<ConvertedModels> finaldataFav = rawDataFav.map((mov) {



          List<String> genrelist = mov.genreIds
              .map(
                (id) => genreMapCombaine[id.toString()] ?? 'unkwn',
              )
              .toList()
              .cast<String>();


              print('genreList : $genrelist');
          
          
          
          
          var voteavg = double.parse(mov.voteAvg);
          var finalratings = (voteavg / 10 * 5);
          return ConvertedModels(
              id: mov.id,
              genreIds: genrelist,
              title: mov.title,
              voteAvg: finalratings.toString(),
              backdropPath: mov.backdropPath,
              posterPath: mov.posterPath,
              overview: mov.overview,
              mediatype: mov.mediaType,
              relaseDate: mov.relaseDate);
        }).toList();




        final List<CombaineModels> rawDataWatchlist = dataWatchlist
            .map(
              (e) => CombaineModels.fromJson(e),
            )
            .toList();
        List<ConvertedModels> finalDataWatchlist = rawDataWatchlist.map((mov) {
          List<String> genreList = mov.genreIds
              .map(
                (id) => genreMapCombaine[id.toString()] ?? 'unklnw',
              )
              .toList()
              .cast<String>();
              print(genreList.length);
          final voteavg = double.parse(mov.voteAvg);
          var finalratings = (voteavg / 10 * 5);
          return ConvertedModels(
              id: mov.id,
              genreIds: genreList,
              title: mov.title,
              voteAvg: finalratings.toString(),
              backdropPath: mov.backdropPath,
              posterPath: mov.posterPath,
              overview: mov.overview,
              mediatype: mov.mediaType,
              relaseDate: mov.relaseDate);
        }).toList();
        emit(UserDataLoaded(
            dataWatchlist: finalDataWatchlist, dataFav: finaldataFav));
      }
    });
  }
}
