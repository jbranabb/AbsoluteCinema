// // ignore_for_file: avoid_print
import 'package:absolutecinema/apiService/model.dart';
import 'package:dio/dio.dart';

String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
Dio dio = Dio();
Future<Map<String, dynamic>> extraData(int id, String mediaType) async {
  final detail = await dio.get('https://api.themoviedb.org/3/$mediaType/$id?api_key=$imdbKey');
  final credits = await dio.get('https://api.themoviedb.org/3/$mediaType/$id/credits?api_key=$imdbKey');
  final videosUrl = await dio.get('https://api.themoviedb.org/3/$mediaType/$id/videos?api_key=$imdbKey');

  List<dynamic> response = videosUrl.data['results'];
  var youtubekey = response.firstWhere(
   (x) => x['type'] == 'Trailer', 
  ); 

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
    'ytkey': youtubekey['key']
    };
}

void test()async{
   String url = 'https://api.themoviedb.org/3/authentication/session/new$imdbKey';
 final respoinse = await dio.post(url, data: {
  "request_token": "3bfdebf07db6d4c7ba85001d935bdc6cc700b871"
 });
 print(respoinse.statusCode);
 print(respoinse.data);

}


void main() async {
test();

 


}
