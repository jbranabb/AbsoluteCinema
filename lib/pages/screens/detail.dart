// ignore_for_file: deprecated_member_use
import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/detail/build_ratings.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/detail/elevated_button_detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionTitleWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/section_caraousel_slider_widget.dart';
import 'package:absolutecinema/state/bloc/cast/cast_bloc.dart';
import 'package:absolutecinema/state/cubit/animatedContainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    super.key,
    required this.voteAvg,
    required this.runtime,
    required this.director,
    required this.tagline,
    required this.date,
    required this.oveview,
    required this.titile,
    required this.backdropImage,
    required this.posterImage,
    required this.country,
    required this.genreNames,
    required this.id,
    required this.mediatype,
  });
  String titile;
  String oveview;
  String backdropImage;
  String posterImage;
  String genreNames;
  String date;
  String voteAvg;
  String runtime;
  String director;
  String tagline;
  String country;
  String? mediatype;
  int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<CastBloc>()
        .add(FetchCast(id: widget.id, mediaType: widget.mediatype.toString()));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        context.read<CastBloc>().add(RestoreCast());
        CircularProgressIndicator();
        return true;
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: SizedBox(
          height: height + 200,
          child: Stack(
            children: [
              Container(
                color: Colors.black,
              ),
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://image.tmdb.org/t/p/w780${widget.backdropImage}'),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 1)
                            ])),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 170,
                  right: 30,
                  child: SizedBox(
                    height: 160,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w300${widget.posterImage}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Positioned(
                  top: 190,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 25,
                        width: 200,
                        child: MyText(
                          text: widget.titile,
                          fnSize: widget.titile.length > 16 ? 16 : 20,
                          fnweight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 180,
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          text: widget.genreNames,
                          fnweight: FontWeight.bold,
                          clors: Colors.grey.shade400,
                          fnSize: widget.genreNames.length > 25 ? 12 : 14,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyText(
                              text: widget.date.substring(0, 4),
                              clors: Colors.grey.shade500,
                              fnSize: 14,
                              fnweight: FontWeight.bold,
                            ),
                            MyText(
                              text: '•   ',
                              fnweight: FontWeight.w800,
                              clors: Colors.grey.shade500,
                            ),
                            MyText(
                              text: 'DIRECTED BY',
                              clors: Colors.grey.shade600,
                              fnSize: 11,
                              fnweight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      MyText(
                        text: ' ${widget.director}',
                        clors: Colors.grey.shade400,
                        fnSize: 15,
                        fnweight: FontWeight.bold,
                      ),
                      //desk
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: MyText(
                              text: widget.runtime,
                              clors: Colors.grey.shade600,
                              fnweight: FontWeight.w600,
                              fnSize: 12,
                            ),
                          ),
                          MyText(
                            text: ' | ',
                            clors: Colors.grey.shade600,
                            fnweight: FontWeight.w600,
                            fnSize: 12,
                          ),
                          buildRatings(
                              int.parse(widget.voteAvg.substring(0, 1))),
                          MyText(
                            text: '| ',
                            clors: Colors.grey.shade600,
                            fnweight: FontWeight.w600,
                            fnSize: 12,
                          ),
                          countrys(widget.country)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.only(left: 2, right: 10),
                                  minimumSize: const Size(50, 30),
                                  backgroundColor: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.black,
                                  ),
                                  MyText(
                                    text: 'Trailer',
                                    clors: Colors.black,
                                    fnweight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            ElevatedButtonDetail(
                              icon: Icons.bookmark,
                            ),
                            ElevatedButtonDetail(
                              icon: Icons.share,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () =>
                              context.read<AnimatedExpands>().changeState(),
                          child: BlocBuilder<AnimatedExpands, bool>(
                            builder: (context, state) {
                              return Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: Durations.medium4,
                                    height: widget.oveview.length > 250
                                        ? state
                                            ? 150
                                            : 110
                                        : 110,
                                    width: width * 0.9,
                                    child: SingleChildScrollView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: widget.tagline.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                  text: widget.tagline,
                                                  clors: Colors.grey.shade400,
                                                  fnweight: FontWeight.bold,
                                                  fnSize: 11,
                                                ),
                                                Text(
                                                  widget.oveview,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.inter(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.oveview,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.inter(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: AnimatedContainer(
                                      duration: Durations.short4,
                                      height: 40,
                                      width: width * 0.9,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: widget.oveview.length >
                                                      250
                                                  ? state
                                                      ? [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.0)
                                                        ]
                                                      : [
                                                          Colors.transparent,
                                                          Colors.grey
                                                              .withOpacity(0.2)
                                                        ]
                                                  : [
                                                      Colors.transparent,
                                                      Colors.transparent
                                                    ])),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
                        child: MyText(
                          text: 'Cast',
                          fnweight: FontWeight.bold,
                          fnSize: 15,
                        ),
                      ),
                      BlocBuilder<CastBloc, CastState>(
                          builder: (context, state) {
                        if (state is StateLoading) {
                          return Container(
                            height: 100,
                            // color: Colors.blue,
                            width: width * 0.95,
                            alignment: Alignment.topCenter,
                            child: LoadingWidget(),
                          );
                        } else if (state is StateError) {
                          return Container(
                            // color: Colors.red,
                            height: 300,
                            width: width * 0.95,
                            child: Text(state.e),
                          );
                        } else if (state is StateLoaded) {
                          return Container(
                            height: 400,
                            // color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 140,
                                  width: width,
                                  // color: Colors.red,
                                  child: CarouselSlider.builder(
                                      itemCount: state.cast.length,
                                      itemBuilder: (context, index, realIndex) {
                                        var cast = state.cast[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                // color: Colors.blue,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w780${cast.profilePath}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                // color: Colors.blueGrey,
                                                child: Column(
                                                  children: [
                                                    MyText(
                                                      text: cast.name,
                                                      fnSize: 10,
                                                      fnweight: FontWeight.w800,
                                                      clors:
                                                          Colors.grey.shade400,
                                                    ),
                                                    MyText(
                                                      text: cast.character,
                                                      fnSize: 9,
                                                      fnweight: FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          viewportFraction: 0.3,
                                          aspectRatio: 16 / 9,
                                          enableInfiniteScroll: false,
                                          padEnds: false)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: MyText(
                                    text: 'You May Also Like',
                                    fnSize: 12,
                                    fnweight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                    width: width,
                                    child: SectionCaraouselSliderWidget(
                                      list: state.recomendations,
                                    ))
                              ],
                            ),
                          );
                        }
                        return Container(
                          color: Colors.amber,
                          height: 10,
                          width: 10,
                          // child: ,
                        );
                      })
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }
}

Widget countrys(String country) {
  switch (country) {
    case == 'United Kingdom':
      return MyText(
          clors: Colors.grey.shade600, fnweight: FontWeight.w600, text: 'UK');
    case == 'United States of America':
      return MyText(
          clors: Colors.grey.shade600, fnweight: FontWeight.w600, text: 'US');
    default:
      return MyText(
          clors: Colors.grey.shade600,
          fnweight: FontWeight.w600,
          text: country);
  }
}
