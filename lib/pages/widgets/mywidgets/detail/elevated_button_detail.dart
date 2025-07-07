import 'package:flutter/material.dart';

class ElevatedButtonDetail extends StatelessWidget {
  ElevatedButtonDetail({super.key, required this.icon});
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(left: 0),
          minimumSize: Size(11, 30),
          fixedSize: Size(45, 30),
          backgroundColor: Colors.white),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
