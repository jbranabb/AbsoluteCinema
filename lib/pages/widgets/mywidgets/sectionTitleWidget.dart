
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SectionTitleWidget extends StatelessWidget {
   SectionTitleWidget({
    super.key,
    required this.title,
  });
String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          GestureDetector(
            child: const Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

