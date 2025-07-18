import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  CredentialsBloc() : super(CredentialsInitial()) {
    on<CheckStatus>((event, emit) async {
      var sesionId = pref?.getString('sessionId');
      var headers = '?session_id=$sesionId&api_key=$imdbKey';
      //url for posting
      // String url = 'https://api.themoviedb.org/3/account/$id/watchlist$headers';
      //url for get staus
      String checkByIdUrl =
          'https://api.themoviedb.org/3/${event.mediaType}/${event.mediaId}/account_states$headers';
      var responseCheck = await dio.get(checkByIdUrl);
      if (responseCheck.statusCode == 200) {
        var dataCheck = responseCheck.data;
        var watchlist = dataCheck['watchlist'] as bool;
        var favorite = dataCheck['favorite'] as bool;
        var rating = dataCheck['rated'] as bool;
        emit(StateChecking(watchlist: watchlist, rated: rating, fav: favorite));
      }
    });
    on<ToggleStatusFav>((event, emit) {
      var fav = event.fav;
      emit(CredentialsStateLoaded(statusFav: !fav,));
    });
    on<ToggleStatusWatchlist>((event, emit) {
      var watch= event.watch;
      emit(CredentialsStateLoaded(statusWatch:!watch ));
    });
  }
}
