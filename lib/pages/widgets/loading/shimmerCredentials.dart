import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCredentials extends StatelessWidget {
   ShimmerCredentials({super.key, });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: 'Loading..',
          fnweight: FontWeight.bold,
          fnSize: 18,
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              null;
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Movies'),
                value: 1,
              ),
              const PopupMenuItem(
                child: Text('Tv Show'),
                value: 2,
              ),
            ],
          )
        ]  ,  
      ),
      body: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
          baseColor: Colors.grey.shade900,
          highlightColor: Colors.grey.shade800,
          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 3 /4),
           itemBuilder: (context, index) {
             return Padding(
               padding: const EdgeInsets.all(3.0),
               child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                 ),
               ),
             );

           },),
          ),
    );
  }
}
