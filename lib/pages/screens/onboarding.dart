import 'package:absolutecinema/pages/screens/auth_page.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/state/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();

    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          context.read<OnboardingCubit>().islastpagge(value);
        },
        children: [
          OnboardingWidget(
            assets: '/svn.jpeg',
            title: 'SAJDJHDSHD',
            subtitle: 'asdadasd',
            controller: _controller,
          ),
          OnboardingWidget(
            assets: '/onb.jpeg',
            title: 'SAJDJHDSHD',
            subtitle: 'asdadasd',
            controller: _controller,
          ),
          OnboardingWidget(
            assets: '/onb2.jpeg',
            title: 'SAJDJHDSHD',
            subtitle: 'asdadasd',
            controller: _controller,
          ),
        ],
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  OnboardingWidget(
      {super.key,
      required this.assets,
      required this.title,
      required this.controller,
      required this.subtitle});
  final String assets;
  final String title;
  final String subtitle;
  PageController controller;

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
            child: Container(
              height: 250,
              width: width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black])),
            )),
        Positioned(
            bottom: height * 0.05,
            left: width * 0.14,
            child: SizedBox(
              height: 100,
              width: 250,
              // color: Colors.amberAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    text: title,
                    fnSize: 18,
                    fnweight: FontWeight.bold,
                  ),
                  MyText(
                    text: subtitle,
                    maxlines: 3,
                  ),
                ],
              ),
            )),
        Positioned(
            bottom: height * 0.04,
            child: Container(
              height: 30,
              width: width,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: SwapEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.grey.shade900,
                          dotHeight: 10,
                          dotWidth: 10),
                    ),
                    BlocBuilder<OnboardingCubit, bool>(
                      builder: (context, state) {
                        return ElevatedButton(
                            onPressed: state !=  true ? () {
                              controller.nextPage(
                                  duration: Durations.medium3,
                                  curve: Curves.easeIn);
                            } : (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage(),));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: MyText(
                              text: state != true ? 'Next' : 'Get Started',
                              clors: Colors.black,
                              fnweight: FontWeight.bold,
                            ));
                      },
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
