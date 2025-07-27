import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmersprofile1 extends StatelessWidget {
  const Shimmersprofile1({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade900,
        highlightColor: Colors.grey.shade800,
        child: Container(
          width: width * 0.90,
          height: height * 0.14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                3,
                (int indx) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                        height: 80,
                        width: width * 0.23,
                        decoration: BoxDecoration(
                  color: Colors.white,
 borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                )),
          ),
        ),
      ),
    );
  }
}
class Shimmersprofile2 extends StatelessWidget {
  const Shimmersprofile2({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade800,
      child: SizedBox(
              height: height * 0.18,
              width: width * 0.95,
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
        childAspectRatio: 9 /13
        ), 
        itemCount: 4,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
              ),
            ),
          ); 
        },)),

    );
  }
}