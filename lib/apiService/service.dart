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
       print(genreMap);  // berhasil munculin genreMap nya  
    }else{
        throw Exception('Gagal Ambil Data Genre');
    }
    String setGrenreNames(List<dynamic> genreList){
        return genreList.map((e) => genreMap[e.toString()] ?? 'unknown',).join(', ');
        
    }
     Map<String, dynamic> mov = {
        "title": "apakabar",
        "genre_ids": [28, 35]
    };
    final texFia = setGrenreNames(mov['genre_ids']);
print(texFia);
}


void main(){
    fetchDataGenres();
}