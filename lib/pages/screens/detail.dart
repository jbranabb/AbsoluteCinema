import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {

 
 DetailPage({super.key, required this.titile, required this.backdropImage, required this.posterImage}); 
String titile;
 String backdropImage;
 String posterImage;

  @override
  Widget build(BuildContext context) {
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
                            imageUrl:
                                'https://image.tmdb.org/t/p/w300$backdropImage'),
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
                  child: Container(height: 130, width: 90, color: Colors.amber,))    
                ,
                Positioned(
                  top: 170,
                  left: 10,
                  child: Column(
                    children: [
                      MyText(text: titile)
                    ],
                  )),
                  ],
            )
    );
  }
}
