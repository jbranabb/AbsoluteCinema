import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    Dio dio = Dio();
    on<GetSessionUser>((event, emit)async {
      emit(UserLoading());
    SharedPreferences _prefs = await SharedPreferences.getInstance();
      // handle terima event dari authbloc
        String accountUrl  =  'https://api.themoviedb.org/3/account?session_id=${event.sesionId}&api_key=$imdbKey';
        final response = await dio.get(accountUrl);
        try{
        if(response.statusCode == 200){
          print('Succes : True'); 
          print("response : ${response.data}");
          // save the reponse data to the sharedprefrences
        _prefs.setString('sessionId', event.sesionId);
        _prefs.setString('username', response.data['username'] ?? 'invalid username');
        _prefs.setString('id', response.data['id'] ?? 'invalid id');
        }else{
          emit(UserFailed(e: response.statusCode.toString()));
        }
        }catch(e){
          emit(UserFailed(e: e.toString()));
        }
    });
    on<UserData>((event, emit)async {
      emit(UserLoading());
    SharedPreferences _prefs = await SharedPreferences.getInstance();      
    var id = _prefs.getString('id');
    var username = _prefs.getString('username');
    emit(UserLoaded(username: username!));
    });
  }
}
