import 'dart:ui';

import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  String title;
  String rating;
  String image;
  String overview;
  DetailPage({
    required this.rating,
    super.key,required this.overview, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
  return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is StateLoaded) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.red,
                      height: 550,
                      width: widthSize,
                      child: ClipRRect(
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://image.tmdb.org/t/p/w300${image}'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          SizedBox(height: 60,),
                          // title
                          Text(title, 
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: title.length > 30 ? 18 : 26 ,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),

                          // rating etc
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyText(text: '122 M',),
                                const Gap(10),
                                MyText(text: '|',),
                                const Gap(10),
                                MyText(text: 'New York',),
                                const Gap(10),
                                MyText(text: '|',),
                                const Gap(10),
                                MyText(text: rating.substring(0,3),),
                                // const Gap(10),
                                ],
                            ),
                            
                        ],) ),
                    ),

                    // back to home
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  print('im working');
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.arrow_back)),
                            // Text(title, style: TextStyle(fontSize: 20, color: Colo))
                            MyText(text: title, fnweight: FontWeight.bold,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // overview
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:  15.0),
                child: Text(overview, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
              )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
