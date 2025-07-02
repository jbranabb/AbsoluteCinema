// // ignore_for_file: avoid_print
import 'package:dio/dio.dart';

String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
Dio dio = Dio();
Future<Map<String, dynamic>> extraData(int id) async {
  final detail =
      await dio.get('https://api.themoviedb.org/3/movie/$id?api_key=$imdbKey');
  final credits = await dio
      .get('https://api.themoviedb.org/3/movie/$id/credits?api_key=$imdbKey');
  List<dynamic> director = credits.data['crew'];
  final crew = director.firstWhere(
    (x) => x['job'] == 'Director',
    orElse: () => 'Unknown',
  );

  var data = detail.data;
  var runtime = data['runtime'];
  var tagline = data['tagline'];
  final jam = runtime ~/ 60;
  final menit = runtime % 60;
  var finalRuntime = '${jam}h ${menit}m';
  List<dynamic> country = data['production_countries'];
  var finalCountry = country.map((e) =>  e['name'],).take(1).join(', ');
    
  return {
    'director': crew['name'],
    'runtime': finalRuntime,
    'tagline': tagline,
    'country': finalCountry,
  };
}

void main() async {
  var data = await extraData(123);
  print(data['runtime']);
  print(data['country']);
}
