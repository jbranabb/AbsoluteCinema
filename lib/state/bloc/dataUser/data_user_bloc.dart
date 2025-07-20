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
      var headers = '?session_id=$sesionId&api_key=$imdbKey';
    String accountUrl = 'https://api.themoviedb.org/3/account$headers';
    String? username = pref?.getString('username');
   var response = await dio.get(accountUrl);
    String? userProfile = response.data['avatar']['tmdb']['avatar_path'];
    pref!.setString('ppath', userProfile!);
    String? profilePath = pref?.getString('ppath');
    emit(DataUserLoaded(username: username!, profilePath: profilePath!));
        print(response.data);
    });
  }
}
