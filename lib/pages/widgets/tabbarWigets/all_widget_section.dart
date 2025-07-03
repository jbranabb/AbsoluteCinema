import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AllWidgetSection extends StatelessWidget {
  const AllWidgetSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is StateLoaded) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      SectionTitle.trendingAll,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      child: const Text(
                        'see all',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.209,
                child: CarouselSlider.builder(
                    itemCount: state.allShows.length,
                    itemBuilder: (context, index, realIndex){
                      var movies = state.allShows[index];
                      return GestureDetector(
                        // onTap: () =>
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => DetailPage(
                            //           titile: movies.title,
                            //           oveview: movies.overview,
                            //           backdropImage: movies.backdropPath,
                            //           posterImage: movies.posterPath,
                            //         ))),
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w300${movies.posterPath}',
                                    placeholder: (context, st) => Center(
                                            child: Text(
                                          movies.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white60),
                                        )),
                                    fit: BoxFit.cover),
                                Positioned(
                                  right: 10,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        movies.voteAvg.substring(0, 3),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: SectionTitle.trendingMovies,
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
                    itemCount: state.trending.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.trending[index];
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
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      SectionTitle.streaming,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      child: const Text(
                        'see all',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.209,
                child: CarouselSlider.builder(
                    itemCount: state.streaming.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.streaming[index];
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
                        reverse: true)),
              ),
              const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  SectionTitle.upcoming,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                height: 170,
                width: double.infinity,
                child: CarouselSlider.builder(
                    itemCount: state.convertedUpComingMovie.length,
                    itemBuilder: (context, index, realIndex) {
                      var movies = state.convertedUpComingMovie[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                        onTap: ()async{
                          var idata  = int.parse(movies.id);
                          var extra = await extraData(idata);
                              Navigator.of(context).push(MaterialPageRoute(builder: 
                              (context)  
                                => DetailPage(oveview: movies.overview, titile: movies.title,
                               backdropImage: movies.backdropPath, posterImage: movies.posterPath,
                               genreNames: movies.genreIds.join(', '),
                               date: movies.relaseDate,
                               voteAvg: movies.voteAvg,
                               country: extra['country'],
                               director: extra['director'],
                               runtime: extra['runtime'],
                               tagline: extra['tagline'],
                               ),));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w300${movies.backdropPath}',
                                placeholder: (context, url) =>
                                    Center(child: MyText(text: movies.title)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            child: Text(
                              movies.title,maxLines: 1,
                              style: GoogleFonts.inter(
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
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      SectionTitle.inTheaters,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      child: const Text(
                        'see all',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: height * 0.21,
                child: CarouselSlider.builder(
                    itemCount: state.inTheaters.length,
                    itemBuilder: (context, index, realIndex) {
                      var tvshows = state.inTheaters[index];
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
                      initialPage: 0,
                      viewportFraction: 0.3,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: SectionTitle.popularTv,
                    ),
                    MyText(
                      text: 'see all',
                    )
                  ],
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
      } else if (state is StateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container();
    });
  }
}
