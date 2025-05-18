import 'dart:ui';

import 'package:absolutecinema/state/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  String title;
  String image;
  String overview;
  DetailPage({super.key,required this.overview, required this.image, required this.title});

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
                      height: 450,
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
                          Text(title, style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),),
                            Text('3H 20M    |    Starts  |     9.8', style: TextStyle(color: Colors.white),),
                            
                        ],) ),
                    ),
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
                            Text(title)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              Text(overview, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
