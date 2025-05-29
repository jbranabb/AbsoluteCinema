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
String apiKey = imdbKey;
String trendingsurl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
String nowPlayingUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$imdbKey';
String tvshowURl = 'https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchData>((event, emit) async {
      emit(StateLoading());
      try {
        var responsetrending = await dio.get(trendingsurl,);
        var responseNowPlaying = await dio.get(nowPlayingUrl);
        if (responsetrending.statusCode == 200 && responseNowPlaying.statusCode == 200) {
          print('Succses : True');
          List<dynamic> datatrening = responsetrending.data['results'];
          final List<TrendingThisWeekModel> moviesTrending = datatrening
          .map((e) => TrendingThisWeekModel.fromJson(e),).toList();
          List<dynamic> dataNowplaying = responseNowPlaying.data['results'];
          final List<NowPlayingModel> moviesNowplaying = dataNowplaying.map((e) => NowPlayingModel.fromjson(e),).toList();
          emit(StateLoaded(trending: moviesTrending, nowplaying:moviesNowplaying ));
        } else {
          emit(StateError('Something Went Wrong'));
          print('Succses : False');
        }
      } catch (e) {
        emit(StateError(e.toString()));
      }
      // now playing
      
    });
  }
}
