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

// upcoming movies
String upcoming = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

//tvshow
String tSurlTrending = 'https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey&&page=2';
String tSurlOTA = 'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey';
String tSurlPopular = 'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey';
String tSurlTopRated = 'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey';
String tSurlAiringToday = 'https://api.themoviedb.org/3/tv/airing_today?api_key=$apiKey';
//popular
String streamingUrl = trendingsurl;
// String popularOnNetflixUrl
String inTheaters = '$movieNowPlaying&with_release_type=5';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchData>((event, emit) async {
      emit(StateLoading());
      try {
        //movies
        var responsetrending = await dio.get(trendingsurl);
        var responUpcoming = await dio.get(upcoming);
        var responseInTherater = await dio.get(inTheaters);
        var responseMovieTopRated = await dio.get(movieTopRated);
        var responStreamingUrl = await dio.get(streamingUrl);
        var responseAll = await dio.get(allUrl);
        //tv
        var responseTvAiringToday = await dio.get(tSurlAiringToday);
        var responseTrendingTv = await dio.get(tSurlTrending);
        var responseTSonTheAir = await dio.get(tSurlOTA);
        var responsePopularTv = await dio.get(tSurlPopular);
        var responseTopRatedTv = await dio.get(tSurlTopRated);
        if (responsetrending.statusCode == 200 &&
            responseMovieTopRated.statusCode == 200) {
          print('Succses : True');
          //On The Air
          List<dynamic> dataOTA = responseTSonTheAir.data['results'];
          final List<OnTheAirModel> finaldataOTA =  dataOTA.map((e) => OnTheAirModel.fromJson(e),).toList();
          //Trending Tv
          List<dynamic> dataTrendingTv =  responseTrendingTv.data['results'];
          final List<TrendingTvModel> finaldataTv = dataTrendingTv.map((e) => TrendingTvModel.fromJson(e),).toList();
          List<dynamic> dataPopularTV = responsePopularTv.data['results'];
          List<PopularTVModel> finalddatPopularTv = dataPopularTV.map((e)=> PopularTVModel.fromJson(e)).toList();
          //Top Rated Tv
          List<dynamic> dataTopRated = responseTopRatedTv.data['results'];
          List<TopRatedTV> finaldataTopRated = dataTopRated.map((e)=> TopRatedTV.fromJson(e)).toList();
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
          List<dynamic> dataAiringToday = responseTvAiringToday.data['results'];
          final List<AiringTvShowsModel> finalDataAiringToday = dataAiringToday
              .map(
                (e) => AiringTvShowsModel.fromJson(e),
              )
              .toList();


          // all
          List<dynamic> dataAll = responseAll.data['results'];
          final List<AllMovTv> all =
              dataAll.map((e) => AllMovTv.fromJson(e)).toList();

          // intheaters
          List<dynamic> dataTheaters = responseInTherater.data['results'];
          List<InTheatersModel> finalDataTheaters = dataTheaters
              .map(
                (e) => InTheatersModel.fromJson(e),
              )
              .toList();

          //streaming
          List<dynamic> dataStreaming = responStreamingUrl.data['results'];
          List<StreamingModel> finalDataStreaming = dataStreaming
              .map(
                (e) => StreamingModel.fromJson(e),
              )
              .toList();

          //upcoming
          List<dynamic> dataUpcoming = responUpcoming.data['results'];
          List<UpcomingModel> finaldataUpcoming =
              dataUpcoming.map((e) => UpcomingModel.fromJson(e)).toList();
          
          emit(StateLoaded(
              trending: moviesTrending,
              movieTopRated: moviesTopRated,
              allShows: all,
              inTheaters: finalDataTheaters,
              streaming: finalDataStreaming,
              upcoming: finaldataUpcoming,
              onTheAir: finaldataOTA,
              popularTv: finalddatPopularTv,
              topRated: finaldataTopRated,
              airingToday: finalDataAiringToday,
              trendingTv: finaldataTv
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
