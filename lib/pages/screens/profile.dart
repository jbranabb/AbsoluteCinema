import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Profile', fnSize: 18,fnweight: FontWeight.bold,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container()
        ],
      ),
    );
  }
}