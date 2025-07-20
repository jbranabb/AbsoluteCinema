import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  CredentialsBloc() : super(CredentialsInitial()) {
    
    on<CheckStatus>((event, emit) async {
      var id = pref?.getInt('id');
      var sesionId = pref?.getString('sessionId');
      var headers = '?session_id=$sesionId&api_key=$imdbKey';
      //url for posting
      String url = 'https://api.themoviedb.org/3/account/$id/watchlist$headers';
      //url for get staus
      String checkByIdUrl =
          'https://api.themoviedb.org/3/${event.mediaType}/${event.mediaId}/account_states$headers';
      var responseCheck = await dio.get(checkByIdUrl);
      if (responseCheck.statusCode == 200) {
        var dataCheck = responseCheck.data;
        var watchlist = dataCheck['watchlist'] as bool;
        var favorite = dataCheck['favorite'] as bool;
        var rating = dataCheck['rated'] as bool;
          print('before click $watchlist');
        emit(StateChecking(watchlist, favorite));
      }
    });
        on<ToggleStatusWatch>((event, emit) {
          var currentState = state;
          if(currentState is StateChecking){
          emit(StateChecking(event.watch!, currentState.fav));
          }
          print('event ${event.watch}');
        });
        on<ToggleStatusFav>((event, emit) {
          var currentState = state;
          if(currentState is StateChecking){
          emit(StateChecking(currentState.watchlist, event.fav!));
          }
          print('event fav ${event.fav}');
        });
      
  }
}
