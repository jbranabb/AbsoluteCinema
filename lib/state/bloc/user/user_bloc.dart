import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    var apiKey = dotenv.env['API_KEY'];
    Dio dio = Dio();
    on<GetSessionUser>((event, emit) async {
      emit(UserLoading());
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      // handle terima event dari authbloc
      String accountUrl =
          'https://api.themoviedb.org/3/account?session_id=${event.sesionId}&api_key=$apiKey';
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
    on<UserCredentials>((event, emit) async {
      emit(UserLoading());
      try{
      var id = pref?.getInt('id');
      var usrname = pref?.getString('username');
      var sesionId = pref?.getString('sessionId');
      var headers = '?session_id=$sesionId&api_key=$apiKey';
      if (
          id == null || sesionId == null) {
        emit(UserFailed(e: 'Failed $id, failed $usrname'));
      }

      String genreUrlMov =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';
      String genreUrlTv =
          'https://api.themoviedb.org/3/genre/tv/list?api_key=$apiKey';

      Map<String, dynamic> genreMapCombaine = {};
      var responseGenreTv = await dio.get(genreUrlTv);
      var responseGenreMov = await dio.get(genreUrlMov);
      List dataGenreMov = responseGenreMov.data['genres'];
      List dataGenreTv = responseGenreTv.data['genres'];
      genreMapCombaine = {
        for (var g in dataGenreTv) g['id'].toString(): g['name'],
        for (var g in dataGenreMov) g['id'].toString(): g['name']
      };
        List<ConvertedModels> allwatchlist = [];
        List<ConvertedModels> allfav = [];
        List<ConvertedModels> allrated = [];


        bool hasMoreData = true;
        int currentPageFav = 1;
          do{
      String favUrl =
          'https://api.themoviedb.org/3/account/$id/favorite/${event.mediaType}$headers&pages=$currentPageFav';
      var responseFAv = await dio.get(favUrl);
        var datafav  =  responseFAv.data;
        int totalPagesfav =datafav['total_pages'];
        List<dynamic> listdatafav = datafav['results'];

        final List<CombaineModels> rawDataFav =
            listdatafav.map((e) => CombaineModels.fromJson(e)).toList();
        List<ConvertedModels> finaldataFav = rawDataFav.map((mov) {
          List<String> genrelist = mov.genreIds
              .map(
                (id) => genreMapCombaine[id.toString()] ?? 'unkwn',
              )
              .toList()
              .cast<String>();

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
        allfav.addAll(finaldataFav);
        currentPageFav++;
        hasMoreData = currentPageFav <= totalPagesfav;
          }while(hasMoreData);

        int currentPagewatch = 1;
          do{
      String watchlistUrl = 'https://api.themoviedb.org/3/account/$id/watchlist/${event.mediaType}$headers&page=$currentPagewatch';
      var responseWatchUrl = await dio.get(watchlistUrl);
        var dataWatch = responseWatchUrl.data;
        int totalPagesWatch = dataWatch['total_pages'];
        List<dynamic> listdatawatch = dataWatch['results'];

        final List<CombaineModels> rawDataWatchlist = listdatawatch
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
        allwatchlist.addAll(finalDataWatchlist);
        currentPagewatch++;
        hasMoreData = currentPagewatch <= totalPagesWatch;
        }while(hasMoreData);

       // <rated>
        int currentPageRated = 1;
       do{
          String ratedUrl =  'https://api.themoviedb.org/3/account/$id/rated/${event.mediaType}$headers&page=$currentPageRated';
      var responseRatedUrl = await dio.get(ratedUrl);
        var datarated = responseRatedUrl.data;
        int totalPagesRated =  datarated['total_pages'];
        List<dynamic> listdataRated = datarated['results'];
        List<CombaineModels> dataCombaineRated =
            listdataRated.map((e) => CombaineModels.fromJson(e)).toList();
        List<ConvertedModels> finaldataRated = dataCombaineRated.map((mov) {
          List<String> genreList = mov.genreIds
              .map(
                (e) => genreMapCombaine[id.toString()],
              )
              .toList()
              .cast<String>();
          double v = double.parse(mov.voteAvg);
          var votedAvg = (v / 10 * 5);
          return ConvertedModels(
              id: mov.id,
              genreIds: genreList,
              title: mov.title,
              voteAvg: votedAvg.toString(),
              backdropPath: mov.backdropPath,
              posterPath: mov.posterPath,
              overview: mov.overview,
              mediatype: mov.mediaType,
              relaseDate: mov.relaseDate);
        }).toList();
        allrated.addAll(finaldataRated);
        currentPageRated++;
        hasMoreData = currentPageRated <= totalPagesRated;
       }while(hasMoreData);

         emit(UserDataLoaded(
          dataWatchlist: allwatchlist,
          dataFav: allfav,
          dataRated: allrated,
        ));
      }catch(e){
        emit(UserFailed(e: e.toString()));
      }
    });
  }
}
