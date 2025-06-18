// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:absolutecinema/pages/widgets/tabbarWigets/all_widget_section.dart';
import 'package:absolutecinema/pages/widgets/widgetsfrist/appbar.dart';
import 'package:absolutecinema/pages/widgets/widgetsfrist/slider.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchData());
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is StateError) {
              return Center(
                child: Text('Something went wrong ${state.e}'),
              );
            }
            if (state is StateLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 600,
                          width: 500,
                          child: Image.asset('assets/images/bg.png'),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const MyAppBar(),
                            SliderWidget(),
                            const SizedBox(
                              height: 30,
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
                            SizedBox(
                              height: 1100,
                              child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    AllWidgetSection(),
                                    Text(
                                      '1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 40,
          width: 200,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.save)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
