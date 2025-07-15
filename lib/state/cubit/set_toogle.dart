import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SetToogle extends Cubit<bool> {
  SetToogle() : super(false);
  void toogleStatus(String mediaType, int mediaId, BuildContext ctx, bool mntd) async{
    emit(!state);
    var id = pref?.getInt('id');
    var sesionId = pref?.getString('sessionId');
    var headers = '?session_id=$sesionId&api_key=$imdbKey';
    String url = 'https://api.themoviedb.org/3/account/$id/watchlist$headers';
    // print(url);
    try{
    var responsePost =  await dio.post(url, data: {
      'media_type': mediaType,
      'media_id': mediaId,
      'watchlist': state
    });
    if(responsePost.statusCode == 200){
      print(responsePost.data);
    print('Berhasil hore');
    }
    print(responsePost.statusCode);
    print('Berhasil');
    if(mntd && state != false){
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Berhasil Menambahkan Ke Wacthlist')));
    }else if(mntd){
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Menghapus Dari Wacthlist')));
    }
    }catch(e){
    print(e);
    throw Exception(e);
    }
  }
}
