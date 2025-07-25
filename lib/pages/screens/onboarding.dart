import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          OnboardingWidget(
            assets: '/svn.jpeg',
            title: 'SAJDJHDSHD',
            subtitle: 'asdadasd',
          ),
          OnboardingWidget(
            assets: '/onb.jpeg',
            title: 'SAJDJHDSHD',
            subtitle: 'asdadasd',
          ),
          OnboardingWidget(
            assets: '/onb2.jpeg',
            title: 'SAJDJHDSHD',
            subtitle: 'asdadasd',
          ),
        ],
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    required this.assets,
    required this.title,
    required this.subtitle
  });
  final String assets;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            'assets/images$assets',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(height: 250,
        width: width,
        decoration:const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Colors.transparent,
            Colors.black
          ])
        ),
        )),
        Positioned(
            bottom: height * 0.05,
            left: width * 0.15,
            child: SizedBox(
              height: 100,
              width: 250,
              // color: Colors.amberAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(text: title,  fnSize: 18, fnweight: FontWeight.bold,),
                  MyText(
                    text:
                        subtitle,
                    maxlines: 3,
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
