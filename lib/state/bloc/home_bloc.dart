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
String genreUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$imdbKey';


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
           Map<String,dynamic> genreMap = {};

      var responseGenre = await dio.get(genreUrl);
      List genre = responseGenre.data['genres'];
        genreMap = {
            for(var g in genre) g['id'].toString() : g['name']
          };

          //On The Air
          List<dynamic> dataOTA = responseTSonTheAir.data['results'];
          final List<TvShowsModels> finaldataOTA =  dataOTA.map((e) => TvShowsModels.fromJson(e),).toList();
          List<ConvertedModels> convertedOntaTV = finaldataOTA.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              var ratings =  double.parse(movie.voteAvg);
              var finalratings =  (ratings / 10  * 5);
              return ConvertedModels(
              id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: finalratings.toString(),
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                    overview: movie.overview,
                    relaseDate: movie.fristAirDate
                    );
            }).toList();

          //Trending Tv
          List<dynamic> dataTrendingTv =  responseTrendingTv.data['results'];
          final List<MoviesModels> finaldataTv = dataTrendingTv.map((e) => MoviesModels.fromJson(e),).toList();
            List<ConvertedModels> convertedTrendingTv = finaldataTv.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.relaseDate,
                    overview: movie.overview);
            }).toList();
            
          List<dynamic> dataPopularTV = responsePopularTv.data['results'];
          List<TvShowsModels> finalddatPopularTv = dataPopularTV.map((e)=> TvShowsModels.fromJson(e)).toList();
            List<ConvertedModels> convertedPopularTv = finalddatPopularTv.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.fristAirDate,
                    overview: movie.overview);
            }).toList();
            
          //Top Rated Tv
          List<dynamic> dataTopRated = responseTopRatedTv.data['results'];
          List<TvShowsModels> finaldataTopRated = dataTopRated.map((e)=> TvShowsModels.fromJson(e)).toList();
           List<ConvertedModels> convertedTopRatedTv = finaldataTopRated.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.fristAirDate,
                    overview: movie.overview);
            }).toList();
          //Trending this week
          List<dynamic> datatrening = responsetrending.data['results'];
          final List<MoviesModels> moviesTrending = datatrening
              .map(
                (e) => MoviesModels.fromJson(e),
              )
              .toList();
                       List<ConvertedModels> convertedTrendingMovies = moviesTrending.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.relaseDate,
                    overview: movie.overview);
            }).toList();

          // now playing
          List<dynamic> dataMovieTopRated =
              responseMovieTopRated.data['results'];
          final List<MoviesModels> moviesTopRated = dataMovieTopRated
              .map(
                (e) => MoviesModels.fromJson(e),
              )
              .toList();
                           List<ConvertedModels> convertedTopRatedMovies = moviesTopRated.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate:movie.relaseDate,
                    overview: movie.overview);
            }).toList();

          //tvShow
          List<dynamic> dataAiringToday = responseTvAiringToday.data['results'];
          final List<TvShowsModels> finalDataAiringToday = dataAiringToday
              .map(
                (e) => TvShowsModels.fromJson(e),
              )
              .toList();
                           List<ConvertedModels> convertedAiringTodayTV = finalDataAiringToday.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.fristAirDate,
                    overview: movie.overview);
            }).toList();



          // all
          List<dynamic> dataAll = responseAll.data['results'];
          final List<MoviesModels> all =
              dataAll.map((e) => MoviesModels.fromJson(e)).toList();

                 List<ConvertedModels> convertedTrendingAll = all.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.relaseDate,
                    overview: movie.overview);
            }).toList();
          // intheaters
          List<dynamic> dataTheaters = responseInTherater.data['results'];
          List<MoviesModels> finalDataTheaters = dataTheaters
              .map(
                (e) => MoviesModels.fromJson(e),
              )
              .toList();
                              List<ConvertedModels> convertedTheatersMovie = finalDataTheaters.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                   relaseDate: movie.relaseDate,
                    overview: movie.overview);
            }).toList();
              

          //streaming
          List<dynamic> dataStreaming = responStreamingUrl.data['results'];
          List<MoviesModels> finalDataStreaming = dataStreaming
              .map(
                (e) => MoviesModels.fromJson(e),
              )
              .toList();
                                          List<ConvertedModels> convertedStreamingMovie = finalDataStreaming.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg: movie.voteAvg,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                    relaseDate: movie.relaseDate,
                    overview: movie.overview);
            }).toList();
              

          //upcoming
          List<dynamic> dataUpcoming = responUpcoming.data['results'];
          List<MoviesModels> finaldataUpcoming =
              dataUpcoming.map((e) => MoviesModels.fromJson(e)).toList();
            
            
            List<ConvertedModels> convertedUpcomingMovie = finaldataUpcoming.map((movie){
              List<String> genreNames = movie.genreIds.map((id)=> genreMap[id.toString()]
              ?? 'unkwn').toList().cast<String>();
              var ratings =  double.parse(movie.voteAvg);
              var finalratings =  (ratings / 10  * 5);
              return ConvertedModels(id: movie.id,
               genreIds: genreNames,
                title: movie.title,
                 voteAvg:finalratings.toString(),
                 relaseDate: movie.relaseDate,
                  backdropPath: movie.backdropPath,
                   posterPath: movie.posterPath,
                    overview: movie.overview);
            }).toList();
           
          emit(StateLoaded(
              trending: convertedTrendingMovies,
              movieTopRated: convertedTopRatedMovies,
              allShows: convertedTrendingAll ,
              inTheaters: convertedTheatersMovie,
              streaming: convertedStreamingMovie,
              upcoming: convertedUpcomingMovie,
              onTheAir: convertedOntaTV,
              popularTv: convertedPopularTv,
              topRatedTv: convertedTopRatedTv,
              airingToday: convertedAiringTodayTV,
              trendingTv: convertedTrendingTv,
              convertedUpComingMovie: convertedUpcomingMovie
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
