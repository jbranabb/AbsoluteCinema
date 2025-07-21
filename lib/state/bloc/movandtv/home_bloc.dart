// ignore_for_file: avoid_print

import 'dart:async';

import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

Dio dio = Dio();

class MediaType {
  static const tv = 'tv';
  static const mov = 'movie';
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    var apiKey = dotenv.env['API_KEY'];

//all
    String allUrl =
        'https://api.themoviedb.org/3/trending/all/week?api_key=$apiKey';

//movies
    String trendingsurl =
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
    String movieTopRated =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    String movieNowPlaying =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';

// upcoming movies
    String upcoming =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

//tvshow
    String tSurlTrending =
        'https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey&&page=2';
    String tSurlOTA =
        'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey';
    String tSurlPopular =
        'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey';
    String tSurlTopRated =
        'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey';
    String tSurlAiringToday =
        'https://api.themoviedb.org/3/tv/airing_today?api_key=$apiKey';
//popular
    String streamingUrl = trendingsurl;
// String popularOnNetflixUrl
    String inTheaters = '$movieNowPlaying&with_release_type=5';
    String genreUrlMov =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';
    String genreUrlTv =
        'https://api.themoviedb.org/3/genre/tv/list?api_key=$apiKey';

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
          Map<String, dynamic> genreMapCombaine = {};
          var responseGenre = await dio.get(genreUrlMov);
          var responseGenreMapTv = await dio.get(genreUrlTv);
          List genre = responseGenre.data['genres'];
          List genreTv = responseGenreMapTv.data['genres'];
          genreMapCombaine = {
            for (var x in genreTv) x['id'].toString(): x['name'],
            for (var x in genre) x['id'].toString(): x['name']
          };

          //On The Air
          List<dynamic> dataOTA = responseTSonTheAir.data['results'];
          final List<CombaineModels> finaldataOTA = dataOTA
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedOntaTV = finaldataOTA.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();
            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                mediatype: MediaType.tv,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                overview: movie.overview,
                relaseDate: movie.relaseDate);
          }).toList();

          //Trending Tv
          List<dynamic> dataTrendingTv = responseTrendingTv.data['results'];
          final List<CombaineModels> finaldataTv = dataTrendingTv
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedTrendingTv = finaldataTv.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                relaseDate: movie.relaseDate,
                mediatype: MediaType.tv,
                overview: movie.overview);
          }).toList();

          List<dynamic> dataPopularTV = responsePopularTv.data['results'];
          List<CombaineModels> finalddatPopularTv =
              dataPopularTV.map((e) => CombaineModels.fromJson(e)).toList();
          List<ConvertedModels> convertedPopularTv =
              finalddatPopularTv.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                mediatype: MediaType.tv,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();

          //Top Rated Tv
          List<dynamic> dataTopRated = responseTopRatedTv.data['results'];
          List<CombaineModels> finaldataTopRated =
              dataTopRated.map((e) => CombaineModels.fromJson(e)).toList();
          List<ConvertedModels> convertedTopRatedTv =
              finaldataTopRated.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                mediatype: MediaType.tv,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();
          //Trending this week
          List<dynamic> datatrening = responsetrending.data['results'];
          final List<CombaineModels> moviesTrending = datatrening
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedTrendingMovies =
              moviesTrending.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                mediatype: MediaType.mov,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();

          // now playing
          List<dynamic> dataMovieTopRated =
              responseMovieTopRated.data['results'];
          final List<CombaineModels> moviesTopRated = dataMovieTopRated
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedTopRatedMovies =
              moviesTopRated.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                mediatype: MediaType.mov,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();

          //tvShow
          List<dynamic> dataAiringToday = responseTvAiringToday.data['results'];
          final List<CombaineModels> finalDataAiringToday = dataAiringToday
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedAiringTodayTV =
              finalDataAiringToday.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                relaseDate: movie.relaseDate,
                mediatype: MediaType.tv,
                overview: movie.overview);
          }).toList();

          // all
          List<dynamic> dataAll = responseAll.data['results'];
          final List<CombaineModels> all =
              dataAll.map((e) => CombaineModels.fromJson(e)).toList();

          List<ConvertedModels> convertedTrendingAll = all.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                mediatype: movie.mediaType,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();
          // intheaters
          List<dynamic> dataTheaters = responseInTherater.data['results'];
          List<CombaineModels> finalDataTheaters = dataTheaters
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedTheatersMovie =
              finalDataTheaters.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                mediatype: MediaType.mov,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();

          //streaming
          List<dynamic> dataStreaming = responStreamingUrl.data['results'];
          List<CombaineModels> finalDataStreaming = dataStreaming
              .map(
                (e) => CombaineModels.fromJson(e),
              )
              .toList();
          List<ConvertedModels> convertedStreamingMovie =
              finalDataStreaming.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();

            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                title: movie.title,
                voteAvg: finalratings.toString(),
                backdropPath: movie.backdropPath,
                mediatype: MediaType.mov,
                posterPath: movie.posterPath,
                relaseDate: movie.relaseDate,
                overview: movie.overview);
          }).toList();

          //upcoming
          List<dynamic> dataUpcoming = responUpcoming.data['results'];
          List<CombaineModels> finaldataUpcoming =
              dataUpcoming.map((e) => CombaineModels.fromJson(e)).toList();

          List<ConvertedModels> convertedUpcomingMovie =
              finaldataUpcoming.map((movie) {
            List<String> genreNames = movie.genreIds
                .map((id) => genreMapCombaine[id.toString()] ?? 'unkwn')
                .toList()
                .cast<String>();
            var ratings = double.parse(movie.voteAvg);
            var finalratings = (ratings / 10 * 5);
            return ConvertedModels(
                id: movie.id,
                genreIds: genreNames,
                mediatype: MediaType.mov,
                title: movie.title,
                voteAvg: finalratings.toString(),
                relaseDate: movie.relaseDate,
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                overview: movie.overview);
          }).toList();

          emit(StateLoaded(
            trending: convertedTrendingMovies,
            movieTopRated: convertedTopRatedMovies,
            allShows: convertedTrendingAll,
            inTheaters: convertedTheatersMovie,
            streaming: convertedStreamingMovie,
            upcoming: convertedUpcomingMovie,
            onTheAir: convertedOntaTV,
            popularTv: convertedPopularTv,
            topRatedTv: convertedTopRatedTv,
            airingToday: convertedAiringTodayTV,
            trendingTv: convertedTrendingTv,
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
