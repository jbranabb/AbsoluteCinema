import 'dart:ui';

import 'package:absolutecinema/pages/widgets/appbar.dart';
import 'package:absolutecinema/pages/widgets/slider.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselSliderController scrollController = CarouselSliderController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchData());
  }

  int lenght = 0;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.maxFinite,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.blue.shade900.withOpacity(0.5),
                  Colors.blue.shade900.withOpacity(0.2),
                  Colors.transparent,
                ],
                    stops: [
                  0.0,
                  0.3,
                  0.7
                ])),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              MyAppBar(),
              SliderWidget(),
              // Container(
              //   color: Colors.red,
              //   height: 300,
              // )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 40,
        width: 200,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:BorderRadius.circular(15) ,
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.white.withOpacity(0.2),),
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.home)),
                IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                IconButton(onPressed: (){}, icon: Icon(Icons.save)),
                IconButton(onPressed: (){}, icon: Icon(Icons.person)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
