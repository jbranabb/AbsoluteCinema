
import 'package:dio/dio.dart';

String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
String apiReadAcsessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODQ2ZWZhOTFhZGNhODllMjY0YjZhYTcyZTJhMzkwNyIsIm5iZiI6MTc0NzM2MTA4Ni4yNzQsInN1YiI6IjY4MjY5ZDNlOTA1OTk2NTJhZWFkYTc1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z2VmQNW5AIVUw0lJ0P9z-gk3RSb7nBAohb-k8egQQmA';
String nowPlayingUrl = 'https://api.themoviedb.org/3/tv/popular?api_key=$imdbKey';
void fetchdio()async{
  Dio dio = Dio();
  var response = await dio.get(nowPlayingUrl);
  if(response.statusCode == 200 ){
    print('Dio : Success');
    print(response.data['results']);
  }else{
    print('Dio : failed');
  }
}

void main(){
  fetchdio();
  // fetchhttp();
}