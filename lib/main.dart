import 'package:absolutecinema/pages/screens/home_page.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:absolutecinema/state/cubit/dot_indicator.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeBloc()),
      BlocProvider(create: (context) => DotIndicator()),
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
      home: const HomePage() ,
    );
  }
}
