// ignore_for_file: avoid_print

import 'package:absolutecinema/apiService/model.dart';
import 'package:dio/dio.dart';
String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
String genreUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$imdbKey';
String movieUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$imdbKey';
Dio dio = Dio();
late Map<String, dynamic> genreMap;
void fetchDataGenres()async{
    var responseGenre =  await dio.get(genreUrl);
    if(responseGenre.statusCode == 200){
        print('berhasil get data');
    
       List<dynamic> genreList =  responseGenre.data['genres'];
        genreMap = {
        for (var g in genreList) g['id'].toString() : g['name'],
       }; 
      //  print(genreMap);  // berhasil munculin genreMap nya  
    }else{
        throw Exception('Gagal Ambil Data Genre');
    }
    String setGrenreNames(List<dynamic> genreList){
        return genreList.map((e) => genreMap[e.toString()] ?? 'unknown',).join(', ');
        
    }
    
    // final texFia =  fetchGenres(mov['genre_ids']).then((value) => print('value : $value'),);
// print('hasil : $texFia');
}


 Future<String> fetchGenres(
  )async{
  late Map<String, dynamic> genreMaps;
  var responseGenreApi = await dio.get(genreUrl);
  if(responseGenreApi.statusCode  == 200 ){
    print('Success : True');
    try{
      List<dynamic> dataApiGenres = responseGenreApi.data['genres'];
      // print('List : $dataApiGenres'); 
      genreMaps = {
      for (var g in dataApiGenres) g['id'].toString() : g['name'] 
      };
    }catch(e){
      throw Exception('Something Went Wrong: $e');
    }
  }
   Map<String, dynamic> mov = {
        "title": "apakabar",
        "genre_ids": [28, 35]
    };
 var responsemov = await dio.get(movieUrl);
 List<dynamic> dataFinal = responsemov.data['results'];
//  print('data final : $dataFinal');
List<GenreFromApi> finaldata = dataFinal.map((x) => GenreFromApi.fromJson(x)).toList();
//  print('data final : ${finaldata[1].genreIds}');
List<dynamic> test = finaldata[1].genreIds.replaceFirst('[', '').replaceAll(']', '').split(' ');
List<dynamic> loopingGenres = [
for(var i = 0 ; i < finaldata.length ; i++){
 finaldata[i].genreIds.replaceFirst('[', '').replaceAll(']', '')
}
]; 

  // var listtest = dataFinal[1]['genre_ids'];
// print(listtest);
//  print('genremap : ${genreMaps.containsKey('genre_ids')}');
  String names(List<dynamic>genreList){
    return genreList.map((e) {
      print('e di dalam $e');
      return genreMaps[e.toString()]?? 'Unknown';
    },).join(', ');
  }
  return names(
    test
    );
}


void main(){
    fetchDataGenres();
    fetchGenres().then((val)=> print(val));
}