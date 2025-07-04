
import 'package:absolutecinema/apiService/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SectionCaraouselSliderWidget extends StatelessWidget {
   SectionCaraouselSliderWidget({
    super.key,
    required this.list
  });
  List<ConvertedModels> list;

  @override
  Widget build(BuildContext context) {
    var height =  MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: 170,
      child: CarouselSlider.builder(
          itemCount: list.length,
          itemBuilder: (context, index, realIndex) {
            var tvshows = list[index];
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
              viewportFraction: 0.69,
              
              enlargeCenterPage: true)),
    );
  }
}
