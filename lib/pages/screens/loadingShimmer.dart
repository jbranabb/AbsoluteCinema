import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height * 0.77,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 150),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
            enabled: true,
            loop: 0,
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey.shade900,
            highlightColor: Colors.grey.shade800,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    color: Colors.white,
                    height: 140,
                    width: 90,
                  ),
                  SizedBox(width: 10,),
                  Container(
                    // color: Colors.white,
                    height: 120,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 20,
                          width: 150,
                          color: Colors.white,
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          color: Colors.white,
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          color: Colors.white,
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],

                    ),
                  ),
                ],
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}
