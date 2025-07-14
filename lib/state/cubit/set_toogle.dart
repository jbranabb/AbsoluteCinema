import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';

class SetToogle extends Cubit<bool> {
  SetToogle() : super(false);
  void toogleStatus(String mediaType, int mediaId) async{
    emit(!state);
    var id = pref?.getString('id');
    var sesionId = pref?.getString('sessionId');
    var headers = '?session_id=$sesionId&api_key=$imdbKey';
    String url = 'https://api.themoviedb.org/3/account/$id/watchlist$headers';
    try{
    var responsePost =  await dio.post(url, data: {
      'media_type': mediaType,
      'media_id': mediaId,
      'watchlist': state
    });
    print('Berhasil');
    }catch(e){
    print(e);
    throw Exception(e);
    }
  }
}
