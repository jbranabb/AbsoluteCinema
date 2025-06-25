import 'package:absolutecinema/apiService/model.dart';
import 'package:dio/dio.dart';
String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
String urlname = 'https://api.themoviedb.org/3/tv/popular?api_key=$imdbKey';
String genreUrl = 'https://api.themoviedb.org/3/genre/movie/list?api_key=$imdbKey';
Dio dio = Dio();
void fetchData()async{
var response = await dio.get(urlname);
if(response.statusCode == 200 ){
  try{
  print('berhasil');
  // print(response.data['results'][0]['genre_ids']);
List<dynamic> data = await response.data['results'];
List<Testing> finaldata = data.map((e)=> Testing.fromJson(e)).toList();
for(var i = 0 ; i < 10; i++){
var datafinal = finaldata[i].genreIds.replaceFirst('[', ' ').replaceAll(']',' ');
print(datafinal);
}
  }catch(e){
  print('gagal: $e');
  }
}else{
  print('gagal');
}
}

void fetchDataGenre()async{
  var resposnsee = await dio.get(genreUrl);
  if(resposnsee.statusCode == 200){
    print('Berhasil Get Genre');
    List<dynamic> data =  resposnsee.data['genres'];
    List<Genres> finalData = data.map((e) =>  Genres.fromJson(e)).toList();
    for(var i = 0 ; i < finalData.length; i++ ){
      print(finalData[i].name);
    }
  }
}
void main(){
  fetchDataGenre();
}