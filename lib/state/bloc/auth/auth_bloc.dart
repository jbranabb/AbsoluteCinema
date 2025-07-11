import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    String requestTokenUrl = 'https://api.themoviedb.org/3/authentication/token/new?api_key=$imdbKey';
    on<AuthRequestToken>((event, emit)async {
      emit(AuthLoading());
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
      emit(AuthLoading());
      try{
     final String sessionURl = 'https://api.themoviedb.org/3/authentication/session/new?api_key=$imdbKey';
     var responseSesion = await dio.post(sessionURl, data: {
      'request_token': event.token
     }, options: Options(
      headers: {
           'Content-Type': 'application/json',
          //  'Authorization': 'Bearer $imdbKey'
      }
     ));
     if(responseSesion.statusCode == 200){
      print('berhasil'); 
      if(responseSesion.data['success'] == true){
      var sessionId = responseSesion.data['session_id'];
      print(sessionId);
      emit(AuthSucces(sessionId: sessionId));
      }else{
        emit(AuthFailed(e: 'GAGAL NULL'));
      }
     }else{
      emit(AuthFailed(e: 'User belum klik alloww'));
     }
      }catch(e){
print('Bermasalah : $e');
      }
    });
    on<AuthDenied>((event, emit){
      emit(AuthInitial());
    });

  }
  
  }
