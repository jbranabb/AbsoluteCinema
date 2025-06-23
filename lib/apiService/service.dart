import 'package:absolutecinema/apiService/model.dart';
import 'package:dio/dio.dart';
String imdbKey = 'd846efa91adca89e264b6aa72e2a3907';
String urlname = 'https://api.themoviedb.org/3/tv/popular?api_key=d846efa91adca89e264b6aa72e2a3907';
Dio dio = Dio();
void fetchData()async{
var response = await dio.get(urlname);
if(response.statusCode == 200 ){
  try{
  print('berhasil');
  // print(response.data['results'][0]['genre_ids']);
List<dynamic> data = await response.data['results'];
List<Testing> finaldata = data.map((e)=> Testing.fromJson(e)).toList();
// print(finaldata[0].genreIds);
for(var i = 0 ; i < 10; i++){
  print(finaldata[i].genreIds);
}
  }catch(e){
  print('gagal: $e');
  }
}else{
  print('gagal');
}
}

void main(){
  fetchData();
}