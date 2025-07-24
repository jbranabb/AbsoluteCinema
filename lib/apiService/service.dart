// // ignore_for_file: avoid_print
import 'package:absolutecinema/apiService/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio dio = Dio();
var apiKey = dotenv.env['API_KEY'];
Future<Map<String, dynamic>> extraData(int id, String mediaType) async {
  final detail = await dio
      .get('https://api.themoviedb.org/3/$mediaType/$id?api_key=$apiKey');
  final credits = await dio.get(
      'https://api.themoviedb.org/3/$mediaType/$id/credits?api_key=$apiKey');
  final videosUrl = await dio.get(
      'https://api.themoviedb.org/3/$mediaType/$id/videos?api_key=$apiKey');

  List<dynamic> response = videosUrl.data['results'];
  var youtubekey = response.firstWhere(
    (x) => x['type'] == 'Trailer',
    orElse: () => {'key': 'no keys'},
  );

  List<dynamic> director = credits.data['crew'];
  final crew = director.firstWhere((x) => x['job'] == 'Director',
      orElse: () => director.firstWhere(
          (t) =>
              t['department'] == 'Directing' ||
              t['known_for_department'] == 'Directing',
          orElse: () => {'name': 'A Man'}));
  late int jam = 0;
  late int menit = 0;
  var data = detail.data;
  if (mediaType != 'tv') {
    var runtime = data['runtime'] ?? '123';
    jam = runtime ~/ 60;
    menit = runtime % 60;
  }
  var tagline = data['tagline'] ?? 'no tagline';
  var finalRuntime = '${jam}h ${menit}m';
  List<dynamic> country = data['production_countries'] ?? [];
  var finalCountry = country
      .map(
        (e) => e['name'],
      )
      .take(1)
      .join(', ');
  var sesason = '${data['number_of_seasons'] ?? '0'} Season';

  return {
    'director': crew['name'] ?? 'no name',
    'rtns': mediaType == 'tv' ? sesason : finalRuntime,
    'tagline': tagline ?? 'no tag',
    'country': finalCountry,
    'ytkey': youtubekey['key']
  };
}

Future<Map<String, dynamic>> externalDirectur(
    String mediaType, String id) async {
  var mediaId = int.parse(id);
  final creditsUrl = await dio.get(
      'https://api.themoviedb.org/3/$mediaType/$mediaId/credits?api_key=$apiKey');
  List<dynamic> creditsData = creditsUrl.data['crew'];
  var crew = creditsData.firstWhere(
    (x) => x['job'] == 'Director',
    orElse: () => creditsData.firstWhere(
      (y) => y['department'] == 'directing',
      orElse: () => creditsData.firstWhere(
        (z) => z['known_for_department'] == 'Directing',
        orElse: () => {'name': 'A Man'},
      ),
    ),
  );
  
  return {'director': crew['name']};
}

void main() async {
  externalDirectur('movie', '234');
}
