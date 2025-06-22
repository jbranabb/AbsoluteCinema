import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TvshowWidgetsSection extends StatelessWidget {
  const TvshowWidgetsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is StateLoaded) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //trending
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: SectionTitle.trendingTv,
                    ),
                    MyText(
                      text: 'see all',
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.21,
                child: CarouselSlider.builder(
                    itemCount: state.trendingTv.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.trendingTv[index];
                      return Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w300${tvshows.posterPath}',
                                placeholder: (context, url) => Center(
                                  child: Text(
                                    tvshows.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        tvshows.voteAvg.substring(0, 3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                      viewportFraction: 0.3,
                    )),
              ),

              // streaming
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: SectionTitle.onTheAir,
                    ),
                    MyText(
                      text: 'see all',
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.21,
                child: CarouselSlider.builder(
                    itemCount: state.onTheAir.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.onTheAir[index];
                      return Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w300${tvshows.posterPath}',
                                placeholder: (context, url) => Center(
                                  child: Text(
                                    tvshows.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        tvshows.voteAvg.substring(0, 3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      reverse: true,
                      initialPage: 0,
                      viewportFraction: 0.3,
                    )),
              ),

              //upcoming
              const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  SectionTitle.popularTv,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                height: 170,
                width: double.infinity,
                child: CarouselSlider.builder(
                    itemCount: state.popularTv.length,
                    itemBuilder: (context, index, realIndex) {
                      var movies = state.popularTv[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w300${movies.backdropPath}',
                              placeholder: (context, url) =>
                                  Center(child: Text(movies.title)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            child: Text(
                              movies.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontSize: movies.title.length >= 30 ? 10 : 15,
                                  color: Colors.white,
                                  
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      );
                    },
                    options: CarouselOptions(
                        viewportFraction: 0.69, enlargeCenterPage: true)),
              ),

              //airing today
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: SectionTitle.airingToday,
                    ),
                    MyText(
                      text: 'see all',
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.21,
                child: CarouselSlider.builder(
                    itemCount: state.airingToday.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.airingToday[index];
                      return Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w300${tvshows.posterPath}',
                                placeholder: (context, url) => Center(
                                  child: Text(
                                    tvshows.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        tvshows.voteAvg.substring(0, 3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                      viewportFraction: 0.3,
                    )),
              ),

              //top rated
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: SectionTitle.topRatedTv),
                    MyText(
                      text: 'see all',
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.21,
                child: CarouselSlider.builder(
                    itemCount: state.topRated.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.topRated[index];
                      return Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w300${tvshows.posterPath}',
                                placeholder: (context, url) => Center(
                                  child: Text(
                                    tvshows.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        tvshows.voteAvg.substring(0, 3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                      viewportFraction: 0.3,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: MyText(
                text: SectionTitle.endOfTheList,
                clors: Colors.grey.shade600,
              )),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }
}
