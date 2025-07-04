import 'package:absolutecinema/apiService/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SectionWidget extends StatelessWidget {
   SectionWidget({
    super.key,
    required this.list,
  });
   List<ConvertedModels> list;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return 
        SizedBox(
          width: double.infinity,
          height: height * 0.209,
          child: CarouselSlider.builder(
              itemCount: list.length,
              itemBuilder: (context, index, realIndex){
                var movies = list[index];
                return GestureDetector(
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
        );    
      }
}
