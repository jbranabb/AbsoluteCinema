
import 'package:absolutecinema/pages/widgets/mywidgets/detail/row_of_ratings.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

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
