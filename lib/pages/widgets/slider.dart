import 'dart:math';

import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:absolutecinema/state/cubit/dot_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderWidget extends StatelessWidget {
   SliderWidget({
    super.key,
    });

  final CarouselSliderController scrollController =  CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is StateLoaded) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text dicover
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
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 170,
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
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w300${movies.backdropPath}',
                                errorWidget: (context, url, error) => Center(
                                  child: Text('Something Went Wrong $error'),
                                ),
                                placeholder: (context, url) => Center(
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
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      // autoPlayInterval: Duration(seconds: 60),
                      // autoPlayCurve: Cur
                    ))),
            BlocBuilder<DotIndicator, int>(builder: (context, currentIndex) {
              return Center(
                child: SizedBox(
                  width: 185,
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
                          margin: EdgeInsets.symmetric(
                              horizontal: isSelected ? 6 : 3),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(isSelected ? 20 : 10),
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.withValues(alpha: 0.5),
                          ),
                        ),
                      );
                    },
                  )),
                ),
              );
            }),
          ],
        );
      }
      return Container();
    });
  }
}
