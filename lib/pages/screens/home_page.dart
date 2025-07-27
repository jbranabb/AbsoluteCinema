// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:absolutecinema/pages/screens/credentials_page.dart';
import 'package:absolutecinema/pages/screens/profile.dart';
import 'package:absolutecinema/pages/screens/search.dart';
import 'package:absolutecinema/pages/screens/watchlis.dart';
import 'package:absolutecinema/pages/widgets/loading/shimmerHomePage.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/tabbarWigets/all_widget_section.dart';
import 'package:absolutecinema/pages/widgets/tabbarWigets/movies_widgets_section.dart';
import 'package:absolutecinema/pages/widgets/tabbarWigets/tvshow_widgets_section.dart';
import 'package:absolutecinema/pages/widgets/widgetsfrist/appbar.dart';
import 'package:absolutecinema/pages/widgets/widgetsfrist/slider.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselSliderController scrollController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is StateError) {
              return Center(
                  child: MyText(text: 'Something Went Wrong\n ${state.e}'));
            }
            if (state is StateLoaded) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.asset(
                              fit: BoxFit.cover, 'assets/images/bg.png'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const MyAppBar(),
                            SliderWidget(),
                            SizedBox(
                              height:
                                  30, //space between dot indicator and tabartitile
                            ),
                            Transform.translate(
                              offset: Offset(-40, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TabBar(
                                  tabs: const [
                                    Text('All'),
                                    Text('Movies'),
                                    Text(
                                      'Tv Shows',
                                    ),
                                  ],
                                  enableFeedback: false,
                                  isScrollable: true,
                                  splashBorderRadius: BorderRadius.circular(20),
                                  dividerHeight: 0,
                                  unselectedLabelColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      AllWidgetSection(),
                      MoviesWidgetsSection(),
                      TvshowWidgetsSection(),
                    ]),
              );
            }
            return Center(
              child: ShimmerHome(),
            );
          },
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Container(
        //   height: 40,
        //   width: 200,
        //   child: Stack(
        //     children: [
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(15),
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        //           child: Container(
        //             color: Colors.white.withOpacity(0.2),
        //           ),
        //         ),
        //       ),
        //       Row(
        //         children: [
        //           IconButton(onPressed: () {}, icon: Icon(Icons.home)),
        //           IconButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => SearchPage(),
        //                 ));
        //               },
        //               icon: Icon(Icons.search)),
        //           IconButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => CredentialsPage(),
        //                 ));
        //               },
        //               icon: Icon(Icons.bookmark)),
        //           IconButton(
        //               onPressed: () {
        //                 Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => ProfilePage(),
        //                 ));
        //               },
        //               icon: Icon(Icons.person)),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
