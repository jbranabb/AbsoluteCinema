import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'data_user_event.dart';
part 'data_user_state.dart';

class DataUserBloc extends Bloc<DataUserEvent, DataUserState> {
  DataUserBloc() : super(DataUserInitial()) {
    on<FetchDataUser>((event, emit)async {
    emit(DataUserLoading());
      var sesionId = pref?.getString('sessionId');
      print('session id = $sesionId');
      var headers = '?session_id=$sesionId&api_key=$imdbKey';
    String accountUrl = 'https://api.themoviedb.org/3/account$headers';
    String? username = pref?.getString('username');
   var response = await dio.get(accountUrl);
    String? avatarPath = response.data['avatar']['tmdb']['avatar_path'];
    String? userProfile;
    if(avatarPath != null){
      userProfile = 'https://image.tmdb.org/t/p/w500$avatarPath';
    }else{
      userProfile = null;
    }
    pref!.setString('ppath', userProfile ?? '');
    String profilePath = pref!.getString('ppath').toString();
    emit(DataUserLoaded(username: username!, profilePath: profilePath));
        print(response.data);
    });
  }
}
