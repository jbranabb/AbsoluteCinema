// // ignore_for_file: avoid_print
import 'package:dio/dio.dart';
String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
Dio dio = Dio();
//genres
String genreUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$imdbKey';
 Map<String,dynamic> genreMap = {};
void fetchGenres()async{
var responseGenre = await dio.get(genreUrl);
      List genre = responseGenre.data['genres'];
        genreMap = {
            for(var g in genre) g['id'].toString() : g['name']
          };
}