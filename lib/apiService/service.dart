// // ignore_for_file: avoid_print

// import 'package:absolutecinema/apiService/model.dart';
// import 'package:dio/dio.dart';
String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
// String genreUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$imdbKey';
// String movieUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$imdbKey';
// Dio dio = Dio();
// late Map<String, dynamic> genreMap;


//  Future<String> fetchGenres(
//   )async{
//   late Map<String, dynamic> genreMaps;
//   var responseGenreApi = await dio.get(genreUrl);
//   if(responseGenreApi.statusCode  == 200 ){
//     print('Success : True');
//     try{
//       List<dynamic> dataApiGenres = responseGenreApi.data['genres'];
//       // print('List : $dataApiGenres'); 
//       genreMaps = {
//       for (var g in dataApiGenres) g['id'].toString() : g['name'] 
//       };
//     }catch(e){
//       throw Exception('Something Went Wrong: $e');
//     }
//   }
//    Map<String, dynamic> mov = {
//         "title": "apakabar",
//         "genre_ids": [28, 35]
//     };
//  var responsemov = await dio.get(movieUrl);
//  List<dynamic> dataFinal = responsemov.data['results'];
// //  print('data final : $dataFinal');
// List<ConvertedModels> finaldata = dataFinal.map((x) => ConvertedModels.fromJson(x)).toList();

//   List<int> parseGenre = finaldata
//   .map((movie) => movie.genreIds)
//   .expand((x)=> x).cast<int>().toList();


//   String names(List<dynamic>genreList){
//     return genreList.map((e) {
//       print('e di dalam $e');
//       return genreMaps[e.toString()]?? 'Unknown';
//     },).toString();
//   }
//   return names(
//     parseGenre
//     );
// }


// void main(){
//     fetchGenres().then((val)=> print(val));
// }