import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(

        children: [
          Center(child: MyText(text: 'data')),
          Center(child: MyText(text: 'data')),
          Center(child: MyText(text: 'data')),
        ],
      ),
    );
  }
}