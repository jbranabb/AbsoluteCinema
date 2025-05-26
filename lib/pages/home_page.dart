  import 'dart:ui';

  import 'package:absolutecinema/pages/widgets/appbar.dart';
  import 'package:absolutecinema/pages/widgets/slider.dart';
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

    int lenght = 0;
    @override
    Widget build(BuildContext context) {
      var mediaQuery = MediaQuery.of(context).size;
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if(state is StateError) {
                return 
                Center(
                  child: Text('Something went wrong ${state.e}'),
                );
                }
              if(state is StateLoaded) {
                return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child:  Stack(
                        children: [
                          Container(
                            height: 700,
                            width: 500,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.blue.shade900.withOpacity(0.5),
                                  Colors.blue.shade900.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                                    stops: [
                                  0.0,
                                  0.3,
                                  0.7
                                ])),
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
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
                                  height: 600,
                                  child: TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [ Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15.0, vertical: 20),
                                                child: const Text(
                                                  'Trending This Week',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                             ],
                                          ),
                                       
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
                          ),
                        ],
                      ),
                        ),
                        SliverGrid.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: state.trending.length,
                         itemBuilder:(context, index) {
                           var movies = state.trending[index];
                           return Card(
                            child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w300${movies.posterPath}'),
                           );
                         },)
                      ],
                    );  
              }
              return Center(child: CircularProgressIndicator(),);
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
