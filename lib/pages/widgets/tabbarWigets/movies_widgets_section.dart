
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesWidgetsSection extends StatelessWidget {
  const MoviesWidgetsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context,state ) {
        if(state is StateLoaded){
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
                          MyText(text: SectionTitle.trendingMovies,),
                          MyText(text: 'see all',)
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
                    
                    // streaming
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(text: SectionTitle.streaming,),
                          MyText(text: 'see all',)
                        ],
                      ),
                    ),
                       SizedBox(
                      width: double.infinity,
                      height: height * 0.21,
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
                            reverse: true,
                            initialPage: 0,
                            viewportFraction: 0.3,
                          )),
                    ),

                    //upcoming
                const Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Text(SectionTitle.upcoming,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 170,
                      width: double.infinity,
                      child: CarouselSlider.builder(
                          itemCount: state.upcoming.length,
                          itemBuilder: (context, index, realIndex) {
                            var movies = state.upcoming[index];
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


                      //theaters
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(text: SectionTitle.inTheaters,),
                          MyText(text: 'see all',)
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

                    //top rated
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(text: SectionTitle.topRatedMov),
                          MyText(text: 'see all',)
                        ],
                      ),
                    ),
                       SizedBox(
                      width: double.infinity,
                      height: height * 0.21,
                      child: CarouselSlider.builder(
                          itemCount: state.movieTopRated.length,
                          itemBuilder: (context, index, realIndex) {
                            var tvshows = state.movieTopRated[index];
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
                        const SizedBox(height: 20,),
            Center(child: MyText(text: SectionTitle.endOfTheList, clors: Colors.grey.shade600,)),
              const SizedBox(height: 80,),
            ],
                    ),
          );
        }
        return Container(); 
      }
    );
  }
}
