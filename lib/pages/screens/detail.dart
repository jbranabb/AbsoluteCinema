import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage(
      {super.key,
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
      required this.genreNames});
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
  @override
  Widget build(BuildContext context) {
    print(buildRatings(int.parse(voteAvg.substring(0,1))),);
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
                    imageUrl: 'https://image.tmdb.org/t/p/w300$backdropImage'),
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
                  imageUrl: 'https://image.tmdb.org/t/p/w300$posterImage',
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
                    text: titile,
                    fnSize: titile.length > 16 ? 16 : 20,
                    fnweight: FontWeight.w800,
                  ),
                ),
                Container(
                  height: 20,
                  width: 180,
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: genreNames,
                    fnweight: FontWeight.bold,
                    clors: Colors.grey.shade400,
                    fnSize: genreNames.length > 25 ? 12 : 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyText(
                        text: date.substring(0, 4),
                        clors: Colors.grey.shade500,
                        fnSize: 14,
                        fnweight: FontWeight.bold,
                      ),
                      MyText(text: '•   ', fnweight: FontWeight.w800, clors: Colors.grey.shade500,),
                       MyText(text: 'DIRECTED BY', clors: Colors.grey.shade600, fnSize: 11, fnweight: FontWeight.w600,),
                    ],
                  ),
                  
                ),
                MyText(text: ' $director', clors: Colors.grey.shade400, fnSize: 15, fnweight: FontWeight.bold,),
                //desk
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                      MyText(text: runtime, clors:Colors.grey.shade600 ,fnweight: FontWeight.w600,),
                MyText(text: ' | ',   clors:Colors.grey.shade600 ,fnweight: FontWeight.w600,),
                buildRatings(int.parse(voteAvg.substring(0,1))),
                MyText(text: ' | ',   clors:Colors.grey.shade600 ,fnweight: FontWeight.w600,),
                MyText(text: country
                  == 'United States of America' ? 'US' :
                   country,  clors:Colors.grey.shade600 ,
                   fnweight: FontWeight.w600,),
                    ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left:2 ,right:10),
                      minimumSize: Size(50, 30),
                        backgroundColor: Colors.white
                      ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.play_arrow_rounded, color: Colors.black,),
                          MyText(text: 'Trailer', clors: Colors.black,fnweight: FontWeight.bold,),
                        ],
                        
                      ),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButtonDetail(icon: Icons.bookmark,),
                      ElevatedButtonDetail(icon: Icons.share,),
                        
                    ],
                  ),
                ),
              ],
            )),
      ],
    ));
  }
}

class ElevatedButtonDetail extends StatelessWidget {
 ElevatedButtonDetail({
    super.key,
    required this.icon
  });
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.only(left: 0),
      minimumSize: Size(11, 30),
      fixedSize: Size(45, 30),
      backgroundColor: Colors.white
    ),
     child: Icon(icon,
      color: Colors.black,),
    );
  }
}
Widget buildRatings(int rating){
  print(rating);
  switch(rating){
    case > 0 && == 1:
    return RowOfRatings( rating: 1,);
    case >=2 && <3:
    return RowOfRatings(rating: 2);
    case >=3 && <4:
    return RowOfRatings(rating: 3);
    case >=4 && <5:
    return RowOfRatings(rating: 4);
    case >= 5 && <6:
    return RowOfRatings(rating: 5); 
    default: 
    return MyText(text: 'No Rating`s yet', fnSize: 12,); 
  }
}

class RowOfRatings extends StatelessWidget {
  int rating;
  RowOfRatings({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(rating, (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.star),
        ),));
  }
}