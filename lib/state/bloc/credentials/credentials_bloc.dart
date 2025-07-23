import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  CredentialsBloc() : super(CredentialsInitial()) {
    var apiKey = dotenv.env['API_KEY'];
    var id = pref?.getInt('id');
    var sesionId = pref?.getString('sessionId');
    var headers = '?session_id=$sesionId&api_key=$apiKey';
    //url for posting
    String urlWatch = 'https://api.themoviedb.org/3/account/$id/watchlist$headers';
    //url for posting
    String urlFav = 'https://api.themoviedb.org/3/account/$id/favorite$headers';
    //url forPost Ratings  
    on<CheckStatus>((event, emit) async {
      //url for get staus
      String checkByIdUrl =
          'https://api.themoviedb.org/3/${event.mediaType}/${event.mediaId}/account_states$headers';
      var responseCheck = await dio.get(checkByIdUrl);
      if (responseCheck.statusCode == 200) {
        var dataCheck = responseCheck.data;
        var watchlist = dataCheck['watchlist'] as bool;
        var favorite = dataCheck['favorite'] as bool;
        var rating = dataCheck['rated'];
        print('before click $watchlist');
        emit(StateChecking(watchlist, favorite));
      }
    });

    on<ToggleStatusWatch>((event, emit) async {
      var currentState = state;
      if (currentState is StateChecking) {
        emit(StateChecking(event.watch!, currentState.fav));
        print(event.watch);
          try {
       var response = await dio.post(urlWatch, data: {
              'media_type': event.mediaType,
              'media_id': event.mediaId,
              'watchlist': event.watch
            });
            print(response.statusCode);
          } catch (e) {
            emit(CredentialsStatefailed());
          }
      }
    });
    on<ToggleStatusFav>((event, emit) async{
      var currentState = state;
      if (currentState is StateChecking) {
        emit(StateChecking(currentState.watchlist, event.fav!));
        var response = await dio.post(urlFav,data: {
              'media_type': event.mediaType,
              'media_id': event.mediaId,
              'favorite': event.fav
        });
        print(response.statusCode);
      }
      print('event fav ${event.fav}');
    });
    on<PostRatings>((event, emit) async {
    var postUrl = 'https://api.themoviedb.org/3/${event.mediaType}/${event.mediaId}/rating$headers';
    var values = (event.value * 10 / 5);
    var response = await dio.post(postUrl, data:{
      'value': values
    } );
      
    });
  }
}
