import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;

String apiKey = 'd846efa91adca89e264b6aa72e2a3907';
String apiReadAcsessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkODQ2ZWZhOTFhZGNhODllMjY0YjZhYTcyZTJhMzkwNyIsIm5iZiI6MTc0NzM2MTA4Ni4yNzQsInN1YiI6IjY4MjY5ZDNlOTA1OTk2NTJhZWFkYTc1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z2VmQNW5AIVUw0lJ0P9z-gk3RSb7nBAohb-k8egQQmA';
String baseUrl = 'https://reqres.in/api/users?pae=2';
void fetchdio()async{
  Dio dio = Dio();
  var response = await dio.get(baseUrl);
  if(response.statusCode == 200 ){
    print('Dio : Success');
    print(response.data['data'][0]['last_name']);
  }else{
    print('Dio : failed');
  }
}
Future<void> fetchhttp()async{
  Uri uri = Uri.parse(baseUrl);
  var response  = await http.get(uri);
  if(response.statusCode == 200){
  var jsonData = jsonDecode(response.body)['data'];
    print('Http : Success');
  print(jsonData[0]['last_name']);
  }else{
    print('Http : failed');

  }
}
void main(){
  fetchdio();
  fetchhttp();
}