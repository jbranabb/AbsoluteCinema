// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:absolutecinema/pages/widgets/appbar.dart';
import 'package:absolutecinema/pages/widgets/slider.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  print('media query height $height');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is StateError) {
              return Center(
                child: Text('Something went wrong ${state.e}'),
              );
            }
            if (state is StateLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 600,
                          width: 500,
                          child: Image.asset('assets/images/bg.png'),
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
                            const MyAppBar(),
                            SliderWidget(),
                            const SizedBox(
                              height: 30,
                            ),
                            Transform.translate(
                              offset: Offset(-40, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TabBar(
                                  tabs: const [
                                    Text('All'),
                                    Text('Movies'),
                                    Text(
                                      'Tv Shows',
                                    ),
                                  ],
                                  enableFeedback: false,
                                  isScrollable: true,
                                  splashBorderRadius: BorderRadius.circular(20),
                                  dividerHeight: 0,
                                  unselectedLabelColor: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 700,
                              child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    AllWidgetSection(height: height),
                                    Text(
                                      '1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 40,
          width: 200,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.save)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AllWidgetSection extends StatelessWidget {
  const AllWidgetSection({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending This Week',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14),
              ),
              GestureDetector(
                child: Text(
                  'see all',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: height * 0.209,
          child: CarouselSlider.builder(
              itemCount: state.trending.length,
              itemBuilder:
                  (context, index, realIndex) {
                var movies =
                    state.trending[index];
                return Card(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                            12),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w300${movies.posterPath}',
                            placeholder:
                                (context, st) =>
                                    Center(
                                        child:
                                            Text(
                                      movies
                                          .title,
                                          textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Colors.white60),
                                    )),
                            fit: BoxFit.cover),
                        Positioned(
                          right: 10,
                          child: Row(
                            children: [
                              Icon(
                                Icons
                                    .star_rounded,
                                color: Colors
                                    .amber,
                              ),
                              Text(
                                movies.rate
                                    .substring(
                                        0, 3),
                                style: TextStyle(
                                    color: Colors
                                        .white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  viewportFraction: 0.3)),
        ),
         Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Streaming Today',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14),
              ),
              GestureDetector(
                child: Text(
                  'see all',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: height * 0.209,
          child: CarouselSlider.builder(itemCount: state.streaming.length, 
          itemBuilder:(context, index, realIndex) {
            var tvshows = state.streaming[index];
            return Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:'https://image.tmdb.org/t/p/w300${tvshows.posterPath}',
                    placeholder: (context, url) =>  Center(child: Text(tvshows.title, textAlign: TextAlign.center,),),
                    ),
                    Positioned(
                      right: 10,
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: Colors.amber,),
                          Text(tvshows.voteAvg.substring(0, 3), style: TextStyle(color: Colors.white),),
                        ],
                      ))
                  ],
                ),
              ),
            );
          }, options: CarouselOptions(
            aspectRatio: 16 / 9,
            initialPage: 0,
            viewportFraction: 0.3,
            reverse: true
          )),
        ),
         Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'In Theaters',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14),
              ),
              GestureDetector(
                child: Text(
                  'see all',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: height * 0.21,
          child: CarouselSlider.builder(itemCount: state.inTheaters.length, 
          itemBuilder:(context, index, realIndex) {
            var tvshows = state.inTheaters[index];
            return Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:'https://image.tmdb.org/t/p/w300${tvshows.posterPath}',
                    placeholder: (context, url) =>  Center(child: Text(tvshows.title, textAlign: TextAlign.center,),),
                    ),
                    Positioned(
                      right: 10,
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: Colors.amber,),
                          Text(tvshows.voteAvg.substring(0, 3), style: TextStyle(color: Colors.white),),
                        ],
                      ))
                  ],
                ),
              ),
            );
          }, options: CarouselOptions(
            aspectRatio: 16 / 9,
            initialPage: 0,
            viewportFraction: 0.3,
          )),
        )
        
      ],
    );
  }
}
