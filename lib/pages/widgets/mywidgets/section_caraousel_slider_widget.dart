
import 'package:absolutecinema/apiService/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            var movies = list[index];
            return Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w300${movies.posterPath}',
                      placeholder: (context, url) => Center(
                        child: Text(
                          movies.title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  Text(
                    movies.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  )
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
