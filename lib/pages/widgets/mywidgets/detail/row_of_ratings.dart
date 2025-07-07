
import 'package:flutter/material.dart';

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
