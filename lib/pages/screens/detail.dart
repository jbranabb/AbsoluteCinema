// ignore_for_file: deprecated_member_use
import 'dart:ui';

import 'package:absolutecinema/apiService/model.dart';
import 'package:absolutecinema/pages/screens/profile.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/detail/build_ratings.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/detail/elevated_button_detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionTitleWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/section_caraousel_slider_widget.dart';
import 'package:absolutecinema/state/bloc/cast/cast_bloc.dart';
import 'package:absolutecinema/state/bloc/credentials/credentials_bloc.dart';
import 'package:absolutecinema/state/cubit/animatedContainer.dart';
import 'package:absolutecinema/state/cubit/ratings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
    required this.ytkey,
  });
  final String titile;
  final String oveview;
  final String backdropImage;
  final String posterImage;
  final String genreNames;
  final String date;
  final String voteAvg;
  final String runtime;
  final String director;
  final String tagline;
  final String country;
  final String? mediatype;
  final int id;
  final String ytkey;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> _launchUrl() async {
    final Uri _url =
        Uri.parse('https://www.youtube.com/watch?v=${widget.ytkey}');
    print('$_url');
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      if (!await launchUrl(_url,
          mode: LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ))) {
        throw Exception('Could not launch the Url');
      }
    } catch (e) {
      print('Error launching URL: $e');
      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch the URL with fallback');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<CastBloc>()
        .add(FetchCast(id: widget.id, mediaType: widget.mediatype.toString()));
    context.read<CredentialsBloc>().add(CheckStatus(
        mediaId: widget.id, mediaType: widget.mediatype!, ctx: context));
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ytkey);
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
          height: height + 150,
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
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 0.5,
                      )),
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
                ),
              ),
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
                              onPressed: _launchUrl,
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
                              icon: Icons.playlist_add,
                              colors: Colors.black,
                              presed: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel: 'hallos',
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return Stack(
                                      children: [
                                        ClipRRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: Container(
                                              color: const Color.fromARGB(
                                                      255, 60, 61, 61)
                                                  .withOpacity(0.6),
                                              child: SizedBox.expand(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: MyText(
                                                        text: widget.titile,
                                                        fnweight:
                                                            FontWeight.bold,
                                                        fnSize: 18,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: MyText(
                                                                fnweight:
                                                                    FontWeight
                                                                        .w400,
                                                                text: widget
                                                                    .date
                                                                    .substring(
                                                                        0, 4)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: MyText(
                                                                fnweight:
                                                                    FontWeight
                                                                        .w400,
                                                                text: '•'),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: MyText(
                                                                fnweight:
                                                                    FontWeight
                                                                        .w400,
                                                                text: widget
                                                                    .runtime),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: height * 0.45,
                                                      width: width * 0.90,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black54,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          BlocBuilder<
                                                              CredentialsBloc,
                                                              CredentialsState>(
                                                            builder: (context,
                                                                state) {
                                                              if (state
                                                                  is StateChecking) {
                                                                return Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            'hallo');
                                                                        context.read<CredentialsBloc>().add(ToggleStatusWatch(
                                                                            widget.id,
                                                                            widget.mediatype!,
                                                                            !state.watchlist!));
                                                                        print(state
                                                                            .watchlist);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            90,
                                                                        width:
                                                                            90,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade900,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              state.watchlist != false ? Icons.watch_later : Icons.watch_later_outlined,
                                                                              size: 30,
                                                                            ),
                                                                            Material(
                                                                                color: Colors.transparent,
                                                                                child: MyText(
                                                                                  text: 'Watchlist',
                                                                                  fnweight: FontWeight.bold,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          70,
                                                                      width: 2,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .grey,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        context.read<CredentialsBloc>().add(ToggleStatusFav(
                                                                            widget.id,
                                                                            widget.mediatype!,
                                                                            !state.fav!));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            90,
                                                                        width:
                                                                            90,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade900,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              state.fav != false ? Icons.favorite : Icons.favorite_border_outlined,
                                                                              size: 30,
                                                                            ),
                                                                            Material(
                                                                                color: Colors.transparent,
                                                                                child: MyText(
                                                                                  text: 'Favorite',
                                                                                  fnweight: FontWeight.bold,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                              return Container();
                                                            },
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            height: 110,
                                                            width: width * 0.75,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade900,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child:
                                                                        MyText(
                                                                      text:
                                                                          'Rateings',
                                                                      fnweight:
                                                                          FontWeight
                                                                              .bold,
                                                                    )),
                                                                // Row(
                                                                //   crossAxisAlignment:
                                                                //       CrossAxisAlignment
                                                                //           .center,
                                                                //   mainAxisAlignment:
                                                                //       MainAxisAlignment
                                                                //           .center,
                                                                //   children: [
                                                                //     Icon(Icons
                                                                //         .star_rate_sharp),
                                                                //     Icon(Icons
                                                                //         .star_rate_sharp),
                                                                //     Icon(Icons
                                                                //         .star_rate_sharp),
                                                                //     Icon(Icons
                                                                //         .star_rate_sharp),
                                                                //     Icon(Icons
                                                                //         .star_rate_sharp),
                                                                //   ],
                                                                // )
                                                                // BlocBuilder<
                                                                //     RatingsCubit,
                                                                //     double>(
                                                                //   builder:
                                                                //       (context,
                                                                //           state) {
                                                                //     return StarRating(
                                                                //         starCount:
                                                                //             5,
                                                                //         allowHalfRating:
                                                                //             true,
                                                                //         color: Colors
                                                                //             .orange,
                                                                //         size:
                                                                //             30,
                                                                //         rating:
                                                                //             state,
                                                                //         onRatingChanged:
                                                                //             (rating) {
                                                                //           context
                                                                //               .read<RatingsCubit>()
                                                                //               .changeRatings(rating);
                                                                //           print(
                                                                //               '$rating');
                                                                //           context.read<CredentialsBloc>().add(PostRatings(
                                                                //               mediaId: widget.id,
                                                                //               mediaType: widget.mediatype!,
                                                                //               value: rating));
                                                                //         });
                                                                //   },
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                                    child: const Text(
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.w600),
                                                                        'Cancel'),
                                                                  )),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20.0),
                                                                    child: Text(
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w600),
                                                                        'Done'),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            ElevatedButtonDetail(
                              icon: Icons.share,
                              colors: Colors.black,
                              presed: () {},
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
                            height: 140,
                            // color: Colors.amber,
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
                                        if (state.recomendations.isNotEmpty) {}
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
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      color:
                                                          Colors.grey.shade300,
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 50,
                                                      ),
                                                    ),
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
                      }),
                      BlocBuilder<CastBloc, CastState>(
                        builder: (context, state) {
                          if (state is StateLoaded &&
                              state.recomendations.isNotEmpty) {
                            var recomendations = state.recomendations;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MyText(
                                    text: 'You May Also Like',
                                    fnSize: 12,
                                    fnweight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: width,
                                  child: SectionCaraouselSliderWidget(
                                      list: recomendations),
                                )
                              ],
                            );
                          }
                          return Container();
                        },
                      )
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
