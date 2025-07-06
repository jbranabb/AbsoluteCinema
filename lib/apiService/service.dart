// // ignore_for_file: avoid_print
import 'package:absolutecinema/apiService/model.dart';
import 'package:dio/dio.dart';

String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
Dio dio = Dio();
Future<Map<String, dynamic>> extraData(int id, String mediaType) async {
  final detail =
      await dio.get('https://api.themoviedb.org/3/$mediaType/$id?api_key=$imdbKey');
  final credits = await dio
      .get('https://api.themoviedb.org/3/$mediaType/$id/credits?api_key=$imdbKey');

  List<dynamic> director = credits.data['crew'];
  final crew = director.firstWhere(
    (x) => x['job'] == 'Director',
    orElse: () => director.firstWhere((t) => t['department'] == 'Directing' 
    || t['known_for_department'] == 'Directing', orElse: 
    ()=> {'name': 'A Man'})
    
  );
  late int jam = 0;
  late int menit = 0;
  var data = detail.data;
  if(mediaType != 'tv'){
  var runtime = data['runtime'] ?? '123';
   jam = runtime ~/ 60;
   menit = runtime % 60;
  }
  var tagline = data['tagline'] ?? 'no tagline';
  var finalRuntime = '${jam}h ${menit}m';
  List<dynamic> country = data['production_countries'];
  var finalCountry = country.map((e) =>  e['name'],).take(1).join(', ');
  List<dynamic> datacast = credits.data['cast'];
  final finaldatacast = datacast.map((e) =>  
    e['name'] ?? 'adsdada').take(5);
  var sesason = '${data['number_of_seasons']} Season';

  return {
    'director': crew['name'] ?? 'no name',
    'rtns': mediaType == 'tv' ?  sesason : finalRuntime,
    'tagline': tagline ?? 'no tag',
    'country': finalCountry,
    // 'cast': finaldatacast.join(', '),
    };
}

Future<Map<String,dynamic>> test(int id, String mediatype,)async{
  String url = 'https://api.themoviedb.org/3/$mediatype/$id?api_key=$imdbKey';
  final response = await dio.get(url);
    var data = response.data;
    print(mediatype);
  return {
    'test': mediatype == 'tv' ?  data['number_of_seasons'] : data['runtime'],
  };
}


void main() async {
// var data  = await test(60625, 'tv',);
// print(data['director']);
// print(data['rtns']);
// print(data['country']);
// print(data['cast']);




}
