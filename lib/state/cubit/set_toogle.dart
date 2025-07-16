import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SetToogle extends Cubit<bool> {
  SetToogle() : super(false);
  void toogleStatus(String mediaType, int mediaId, BuildContext ctx, bool mntd) async{
    var id = pref?.getInt('id');
    var sesionId = pref?.getString('sessionId');
    var headers = '?session_id=$sesionId&api_key=$imdbKey';
    String url = 'https://api.themoviedb.org/3/account/$id/watchlist$headers';
    String responseByIdUrl = 'https://api.themoviedb.org/3/$mediaType/$mediaId/account_states$headers';
    // print(url);

    try{
      var responsebyId = await  dio.get(responseByIdUrl);
    bool statusbyId =  responsebyId.data['watchlist']as bool;
    if(!mntd) return;
    if(statusbyId != true){
    var responsePost =  await dio.post(url, data: {
      'media_type': mediaType,
      'media_id': mediaId,
      'watchlist': true
    }); 
    print(responsePost.data);
    }else{
      var responsePost =  await dio.post(url, data: {
      'media_type': mediaType,
      'media_id': mediaId,
      'watchlist': false
    }); 
    print(responsePost.data);
    }
      // ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating, duration: Durations.extralong3,content: Text('Berhasil Menambahkan Ke Wacthlist')));
    }catch(e){
    print(e);
    throw Exception(e);
    }
  }
}
