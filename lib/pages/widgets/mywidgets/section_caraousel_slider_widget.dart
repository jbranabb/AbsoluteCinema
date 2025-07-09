import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/cast/cast_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SectionCaraouselSliderWidget extends StatelessWidget {
  SectionCaraouselSliderWidget({super.key, required this.list});
  List<ConvertedModels> list;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          height: 170,
          width: double.infinity,
          child: CarouselSlider.builder(
              itemCount: list.length,
              itemBuilder: (context, index, realIndex) {
                var movies = list[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: LoadingWidget()),
                        );
                        try {
                          var idata = int.parse(movies.id);
                          var extra = await extraData(
                              idata, movies.mediatype.toString());
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<CastBloc>(),
                              child: DetailPage(
                                oveview: movies.overview,
                                titile: movies.title,
                                backdropImage: movies.backdropPath,
                                posterImage: movies.posterPath,
                                genreNames: movies.genreIds.join(', '),
                                date: movies.relaseDate,
                                voteAvg: movies.voteAvg,
                                country: extra['country'],
                                director: extra['director'],
                                runtime: extra['rtns'],
                                tagline: extra['tagline'],
                                ytkey: extra['ytkey'],
                                id: int.parse(movies.id),
                                mediatype: movies.mediatype,
                              ),
                            ),
                          ));
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                        'Sorry Something Went Wrong'),
                                    content: Text(e.toString()),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'))
                                    ],
                                  ));
                          Navigator.of(context).pop();
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(8),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w780${movies.backdropPath}',
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
                        movies.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
              },
              options: CarouselOptions(
                  viewportFraction: 0.69, enlargeCenterPage: true))),
    );
  }
}
