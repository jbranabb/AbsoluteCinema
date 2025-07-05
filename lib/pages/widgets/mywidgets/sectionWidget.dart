import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SectionWidget extends StatelessWidget {
  SectionWidget({
    super.key,
    required this.list,
    required this.isreverse,
    required this.initialpage,
  });
  List<ConvertedModels> list;
  bool isreverse;
  int initialpage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: height * 0.209,
      child: CarouselSlider.builder(
          itemCount: list.length,
          itemBuilder: (context, index, realIndex) {
            var movies = list[index];
            return GestureDetector(
              onTap: () async {
                print('List : ${list.length}');
                print('title : ${movies.title}');
                print('voteavg : ${movies.voteAvg}');
                print('backdropPath : ${movies.backdropPath}');
                print('id : ${movies.id}');
                print('relaseDate : ${movies.relaseDate}');
                print('genreIDs : ${movies.genreIds}');
                showDialog(
                  context: context,
                  builder: (context) =>
                       const Center(child:LoadingWidget()),
                );
                try {
                  var idata = int.parse(movies.id);
                  var extra = await extraData(idata);
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPage(
                      oveview: movies.overview,
                      titile: movies.title,
                      backdropImage: movies.backdropPath,
                      posterImage: movies.posterPath,
                      genreNames: movies.genreIds.join(', '),
                      date: movies.relaseDate,
                      voteAvg: movies.voteAvg,
                      country: extra['country'],
                      director: extra['director'],
                      runtime: extra['runtime'],
                      tagline: extra['tagline'],
                    ),
                  ));
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Sorry Something Went Wrong',style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                            content: Text(
                              e.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
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
                                style: const TextStyle(color: Colors.white60),
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
                              style: const TextStyle(color: Colors.white),
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
              initialPage: initialpage,
              reverse: isreverse,
              viewportFraction: 0.3)),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
     children: [
     const SizedBox(
         height: 10,
         width: 45,
         child: CircularProgressIndicator()),
         const SizedBox(height: 5,),
         MyText(text: 'Loading Please Wait...',fnSize: 10, fnweight: FontWeight.bold,)
     ],
                          );
  }
}
