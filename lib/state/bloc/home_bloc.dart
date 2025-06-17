// ignore_for_file: avoid_print

import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

Dio dio = Dio();
// apiKey
String apiKey = imdbKey;
//all
String allUrl =
    'https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey';
//movies
String trendingsurl =
    'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
String movieTopRated =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=$imdbKey';
String movieNowPlaying =
    'https://api.themoviedb.org/3/movie/now_playing?api_key=$imdbKey';

//tvshow
String tvshowURlTrending=
    'https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey';

//popular
String streamingUrl = trendingsurl;
// String popularOnNetflixUrl
String inTheaters = '$movieNowPlaying&with_release_type=5';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchData>((event, emit) async {
      emit(StateLoading());
      try {
        var responsetrending = await dio.get(
          trendingsurl,
        );
        var responseInTherater =  await dio.get(inTheaters);
        var responseMovieTopRated = await dio.get(movieTopRated);
        var responseTvShow = await dio.get(tvshowURlTrending);
        var responseAll = await dio.get(allUrl);
        var responStreamingUrl=  await  dio.get(streamingUrl);
        if (responsetrending.statusCode == 200 &&
            responseMovieTopRated.statusCode == 200) {
          print('Succses : True');
          //Trending this week
          List<dynamic> datatrening = responsetrending.data['results'];
          final List<TrendingThisWeekModel> moviesTrending = datatrening
              .map(
                (e) => TrendingThisWeekModel.fromJson(e),
              )
              .toList();

          // now playing
          List<dynamic> dataMovieTopRated =
              responseMovieTopRated.data['results'];
          final List<NowPlayingModel> moviesTopRated = dataMovieTopRated
              .map(
                (e) => NowPlayingModel.fromjson(e),
              )
              .toList();

          //tvShow
          List<dynamic> dataTvShow = responseTvShow.data['results'];
          final List<TrendingTvShow> tvShows = dataTvShow
              .map(
                (e) => TrendingTvShow.fromJson(e),
              )
              .toList();

          // all
          List<dynamic> dataAll = responseAll.data['results'];
          final List<AllMovTv> all =
              dataAll.map((e) => AllMovTv.fromJson(e)).toList();

              // intheaters
              List<dynamic> dataTheaters =  responseInTherater.data['results'];
              List<InTheatersModel> finalDataTheaters = dataTheaters.map((e) => InTheatersModel.fromJson(e),).toList();

              //streaming
              List<dynamic> dataStreaming  =  responStreamingUrl.data['results'];
              List<StreamingModel> finalDataStreaming = dataStreaming.map((e) => StreamingModel.fromJson(e),).toList();
          emit(StateLoaded(
              trending: moviesTrending,
              movieTopRated: moviesTopRated,
              thshows: tvShows,
              allShows: all,
              inTheaters: finalDataTheaters,
              streaming: finalDataStreaming,
              ));
        } else {
          emit(StateError('Something Went Wrong'));
          print('Succses : False');
        }
      } catch (e) {
        emit(StateError(e.toString()));
          print('Succses : False');
      }
      // now playing
    });
  }
}
