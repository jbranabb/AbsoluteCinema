import 'package:absolutecinema/apiService/service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    SharedPreferences? _prefs;
    Dio dio = Dio();
    on<GetSessionUser>((event, emit)async {
      // handle terima event dari authbloc
        String accountUrl  =  'https://api.themoviedb.org/3/account?session_id=${event.sesionId}&api_key=$imdbKey';
        final response = await dio.get(accountUrl);
        try{
        if(response.statusCode == 200){
          print('Succes : True'); 
          print("response : ${response.data}");
        }else{
          emit(UserFailed(e: response.statusCode.toString()));
        }
        }catch(e){

        }
      // handle get data dri shared prefrerences
      // handle emit state data like use name, etc

      // handle save event dari bloc ke shared prefrences
      // _prefs.
    });
  }
}
