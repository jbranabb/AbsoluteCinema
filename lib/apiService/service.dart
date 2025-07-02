// // ignore_for_file: avoid_print
import 'package:dio/dio.dart';
String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
Dio dio = Dio();
// Future<Map<String,dynamic>> extraData(int id)async {
//     final detail = await dio.get('https://api.themoviedb.org/3/movie/$id?api_key=$imdbKey');
//   final credits = await dio.get('https://api.themoviedb.org/3/movie/$id/credits?api_key=$imdbKey');


// List<dynamic> director = credits.data['cast'];
// final crew =  director.firstWhere();
//   return {};
// }

void test()async{
   final credits = await dio.get('https://api.themoviedb.org/3/movie/238/credits?api_key=$imdbKey');
List<dynamic> director = credits.data['crew'];
final crew = director.firstWhere((x) =>  x['job'] == 'Director',orElse: () => 'Unknown',);
print(crew['name']);

}
void main()async{
  print('object');
    test();
}