import 'dart:math';

import 'package:absolutecinema/pages/widgets/appbar.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:absolutecinema/state/cubit/dot_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselSliderController scrollController = CarouselSliderController();
    int inerCurrentPage = 0;
    bool b = false ;
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
                    SizedBox(height: 10),
                    MyAppBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Discover Youre Next\nFavorite Movie.',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.interTight(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                            height: 180,
                            width: double.infinity,
                            child: CarouselSlider.builder(
                                carouselController: scrollController,
                                itemCount: min(10, state.trending.length),
                                itemBuilder: (context, index, realIndex) {
                                  var movies = state.trending[index];
                                  return Stack(
                                    children: [
                                      Container(
                                        width: 580,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w300${movies.posterPath}',
                                            errorWidget:
                                                (context, url, error) => Center(
                                              child: Text(
                                                  'Something Went Wrong $error'),
                                            ),
                                            placeholder: (context, url) =>
                                                Center(
                                              child: Text(movies.title),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.8,
                                  onPageChanged: (index, reason) {
                                    context.read<DotIndicator>().changeState(index);
                                  },
                                  autoPlayAnimationDuration:
                                    const  Duration(seconds: 1),
                                  // autoPlayInterval: Duration(seconds: 60),
                                  // autoPlayCurve: Cur
                                ))),
                        
                      ],
                    ),
                    BlocBuilder<DotIndicator, int>(
                      builder: (context, currentIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 110,vertical: 10),
                          child: Row(
                              children: List<Widget>.generate(
                            min(10, state.trending.length),
                            (index) {
                              bool isSelected = currentIndex == index;
                              return GestureDetector(
                                onTap: () { 
                                  scrollController.animateToPage(index);
                                },
                                child: AnimatedContainer(
                                  duration: Durations.medium1,
                                  height: 10,
                                  width: isSelected ? 25 : 10,
                                  margin: EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(isSelected ? 20 : 10),
                                  color: isSelected ? Colors.white : Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                              );
                            },
                          )),
                        );
                      }
                    ),
                  ],
                ),
              ],
            );
          } else if (state is StateLoading) {
            return Column(
              children: [
                Container(
                  height: 30,
                  width: 200,
                  color: Colors.blue.shade900,
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
