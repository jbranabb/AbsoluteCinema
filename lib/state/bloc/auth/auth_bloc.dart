import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    String requestTokenUrl = 'https://api.themoviedb.org/3/authentication/token/new?api_key=$imdbKey';
    on<AuthRequestToken>((event, emit)async {
      var responseToken = await dio.get(requestTokenUrl);
      if(responseToken.statusCode == 200 && responseToken.data['success'] == true){
      var token =  responseToken.data['request_token'];
      final String url = 'https://www.themoviedb.org/authenticate/$token';
      emit(AuthLoaded(url: url, token: token));
      }else{
      emit(AuthFailed(e: 'User belum klik alloww'));
      }
    });
    on<AuthExchangeToken>((event, emit)async {
     final String sessionURl = 'https://api.themoviedb.org/3/authentication/session/new/${event.token}';
     var responseSesion = await dio.post(sessionURl, data: {
      'request_token': event.token
     });
     if(responseSesion.statusCode == 200 && responseSesion.data['success'] == true){
      var sessionId = responseSesion.data['session_id'];
      emit(AuthSucces(sessionId: sessionId));
     }else{
      emit(AuthFailed(e: 'User belum klik alloww'));
     }
    });

  }
  
  }
