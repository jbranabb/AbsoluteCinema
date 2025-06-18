import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()=> fetchData(),  child: Icon(Icons.timer_3_select_rounded)),
      ),
    );
  }
}

      Dio dio = Dio();
void fetchData()async{
  print('Tunggu Sebentar ya..');
  var response = await dio.get(tSurlOTA);
  if(response.statusCode == 200){
    print('berhasil');
    print(response.data['page']);
    print(response.data['results']);
  }
}