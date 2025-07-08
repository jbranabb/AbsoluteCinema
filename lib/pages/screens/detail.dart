// ignore_for_file: deprecated_member_use
import 'package:absolutecinema/pages/widgets/mywidgets/detail/build_ratings.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/detail/elevated_button_detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
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
    context.read<CastBloc>().add(FetchCast(id:widget.id, mediaType: widget.mediatype.toString()));
     }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
          height: height + 300,
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
                        buildRatings(int.parse(widget.voteAvg.substring(0, 1))),
                        MyText(
                          text: '| ',
                          clors: Colors.grey.shade600,
                          fnweight: FontWeight.w600,
                          fnSize: 12,
                        ),
                        MyText(
                          text: widget.country == 'United States of America'
                              ? 'US'
                              : widget.country,
                          clors: Colors.grey.shade600,
                          fnweight: FontWeight.w600,
                          fnSize: 12,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(left: 2, right: 10),
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
                        onTap: () => context.read<AnimatedExpands>().changeState(),
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
                                    physics: const NeverScrollableScrollPhysics(),
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
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w600,
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
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w600,
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
                                            colors: widget.oveview.length > 250
                                                ? state
                                                    ? [
                                                        Colors.transparent,
                                                        Colors.grey.withOpacity(0.0)
                                                      ]
                                                    : [
                                                        Colors.transparent,
                                                        Colors.grey.withOpacity(0.2)
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
                      child: MyText(text: 'Cast', fnweight: FontWeight.bold,fnSize: 15, ),
                    ),
                    BlocBuilder<CastBloc, CastState>(builder: (context, state) {
                      if (state is StateLoading) {
                        return Container(
                          height: 100,
                          // color: Colors.blue,
                          width: width * 0.95,
                          alignment: Alignment.topCenter,
                          child:LoadingWidget(),
                        );
                      } else if (state is StateError) {
                        return Container(
                          // color: Colors.red,
                          height: 300,
                          width: width * 0.95,
                          child: Text(state.e),
                        );
                      } else if (state is StateLoaded) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.amber,
                                height: height * 0.28,
                                // width: width * 0.95,
                                // color: Colors.red,
                                alignment: Alignment.topCenter,
                                child: CarouselSlider.builder(
                                    itemCount: state.cast.length,
                                    itemBuilder: (context, index, realIndex) {
                                      var cast = state.cast[index];
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 110,
                                                width: 90,
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadiusGeometry.circular(50),
                                                      child: Container(
                                                        height: 70,
                                                        width: 70,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(30)),
                                                        child: CachedNetworkImage(
                                                          imageUrl:
                                                              'https://image.tmdb.org/t/p/w780${cast.profilePath}',
                                                          fit: BoxFit.cover,
                                                          placeholder: (context, url) =>
                                                              Center(
                                                            child: MyText(
                                                              text: cast.name,
                                                              fnweight: FontWeight.bold,
                                                              fnSize: 9,
                                                            ),
                                                          ),
                                                          errorWidget: (context, url,
                                                                  error) =>
                                                              Container(
                                                                  color: Colors.grey.shade400,
                                                                  child: const Icon(
                                                                    Icons.person,
                                                                    size: 47,
                                                                  )),
                                                        ),
                                                      ),
                                                    ),
                                                    MyText(
                                                      text: cast.name,
                                                      fnSize: 11,
                                                      fnweight: FontWeight.bold,
                                                    ),
                                                    MyText(
                                                      text: cast.character,
                                                      fnSize: 10,
                                                      fnweight: FontWeight.w600,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    options: CarouselOptions(
                                        viewportFraction: 0.28,
                                        reverse: false,
                                        initialPage: 0,
                                        padEnds: false,
                                        enableInfiniteScroll: false)),
                              ),
                              Container(
                                height: 200,
                                color: Colors.orange,
                              )
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
        ));
  }
}

