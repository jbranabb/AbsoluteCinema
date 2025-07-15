import 'package:flutter/material.dart';

class ElevatedButtonDetail extends StatelessWidget {
  ElevatedButtonDetail({super.key, required this.icon,
  required this.presed
  });
  IconData? icon;
  void Function()? presed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: presed,
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
