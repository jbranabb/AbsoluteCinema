import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/cast/cast_bloc.dart';
import 'package:absolutecinema/state/cubit/animatedContainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
int idp = 0;
class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();
   context.read<CastBloc>().add(FetchCast(id:widget.id,mediaType: widget.mediatype.toString() ));
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print('titile : ${widget.titile}');
    print('backdropImage :${widget.backdropImage}');
    print('posterImage :${widget.posterImage}');
    print('genreNames :${widget.genreNames}');
    print('date :${widget.date}');
    print('voteAvg :${widget.voteAvg}');
    print('runtime :${widget.runtime}');
    print('director :${widget.director}');
    print('tagline :${widget.tagline.length}');
    print('country :${widget.country}');
    print('oveview :${widget.oveview.length}');
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Container(
          height: 250,
          child: Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: 'https://image.tmdb.org/t/p/w780${widget.backdropImage}'),
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
                  imageUrl: 'https://image.tmdb.org/t/p/w300${widget.posterImage}',
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
                            padding: EdgeInsets.only(left: 2, right: 10),
                            minimumSize: Size(50, 30),
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
                BlocBuilder<CastBloc, CastState>(builder: (context, state) {
                  if (state is StateLoaded) {
                    var cast =  state.cast[0];
                    return Container(
                      height: 300,
                      width: width * 0.95,
                      child: MyText(text:  cast.name),
                      color: Colors.red,
                    );
                  }else if(state is StateError){
                   return Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                    child: Text(state.e),
                   );
                  }else if(state  is StateLoading){
                    return Center(child: LoadingWidget(),);
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
    ));
  }
}

class ElevatedButtonDetail extends StatelessWidget {
  ElevatedButtonDetail({super.key, required this.icon});
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(left: 0),
          minimumSize: Size(11, 30),
          fixedSize: Size(45, 30),
          backgroundColor: Colors.white),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

Widget buildRatings(int rating) {
  // print(rating);
  switch (rating) {
    case > 0 && == 1:
      return RowOfRatings(
        rating: 1,
        size: 22,
      );
    case >= 2 && < 3:
      return RowOfRatings(
        rating: 2,
        size: 20,
      );
    case >= 3 && < 4:
      return RowOfRatings(
        rating: 3,
        size: 18,
      );
    case >= 4 && < 5:
      return RowOfRatings(
        rating: 4,
        size: 16,
      );
    case >= 5 && < 6:
      return RowOfRatings(
        rating: 5,
        size: 14,
      );
    default:
      return MyText(
        text: 'No Rating`s yet',
        fnSize: 12,
        clors: Colors.grey.shade500,
      );
  }
}

class RowOfRatings extends StatelessWidget {
  int rating;
  double? size;
  RowOfRatings({super.key, required this.rating, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          rating,
          (index) => Padding(
            padding: const EdgeInsets.all(0.2),
            child: Icon(
              Icons.star,
              size: size,
            ),
          ),
        ));
  }
}
