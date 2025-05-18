import 'package:absolutecinema/pages/detail.dart';
import 'package:absolutecinema/pages/home_page.dart';
import 'package:absolutecinema/state/home_bloc.dart';
import 'package:absolutecinema/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeBloc()..add(FetchData(),))
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dark,  
      home: HomePage() ,
    );
  }
}
