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
  int inerCurrentPage = 0;
  bool b = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchData());
  }

  int lenght = 0;
  @override
  Widget build(BuildContext context) {
    print('check inner page $inerCurrentPage');
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is StateLoaded) {
            return Stack(
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
                        Colors.transparent,
                      ])),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    MyAppBar(), // app bar
                    SliderWidget(), // Title Text, Caorusel Slider, 
                  ],
                ),
              ],
            );
          } else if (state is StateLoading) {
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue.shade900,
                  ),
                )
              ],
            );
          } else if (state is StateError) {
            return Container(
              child: Center(
                child: Text(
                  'Something went Wrong ${state.e}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return Container(child: const Text('YOu got me'));
        },
      ),
    );
  }
}

