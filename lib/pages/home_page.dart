import 'package:absolutecinema/pages/detail.dart';
import 'package:absolutecinema/pages/widgets/appbar.dart';
import 'package:absolutecinema/state/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = CarouselSliderController();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchData());
  }

  int lenght = 0;
  @override
  Widget build(BuildContext context) {
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
                    MyAppBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Discover Youre Next\nFavorite Pingnie.',
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
                    Container(
                        height: 180,
                        width: double.infinity,
                        child: CarouselSlider.builder(
                            itemCount: state.trending.length,
                            itemBuilder: (context, index, realIndex) {
                              var movies = state.trending[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: 580,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w300${movies.posterPath}',
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child:
                                            Text('Something Went Wrong $error'),
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: Text(movies.title),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions())),
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
