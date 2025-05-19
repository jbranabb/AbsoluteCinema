import 'package:absolutecinema/pages/detail.dart';
import 'package:absolutecinema/state/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchData());
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Absolute',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w900),
            ),
            const Text(' '),
            Text(
              'Cinema',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is StateLoaded) {
            print(state.trending.length);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Trendings This Week',
                          style: GoogleFonts.dmSerifText(
                              color: Colors.white, fontSize: 25),
                        )),
                  ),
                  SizedBox(
                    height: 250,
                    child: GridView.builder(
                      itemCount: state.trending.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 2.0,
                              mainAxisExtent: 150),
                      itemBuilder: (context, index) {
                        var mov = state.trending[index];
                        var title = state.trending[index].title;
                        var image = state.trending[index].posterPath;
                        var overview = state.trending[index].overview;
                        var rating = state.trending[index].rate;
                        return Card(
                          child: GestureDetector(
                            onTap: () {
                              print(title.length);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        overview: overview,
                                        rating: rating,
                                        image: image,
                                        title: title,
                                      )));
                            },
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    fit: BoxFit.cover,
                                    'https://image.tmdb.org/t/p/w300${mov.posterPath}'),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(20),
                  SizedBox(
                    height: 1000,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.0 ,
                      crossAxisSpacing: 0.0 ,
                      mainAxisSpacing: 3.0,
                      mainAxisExtent: 400,
                      crossAxisCount: 2),
                     itemCount: state.nowplaying.length,
                     itemBuilder: (context, index) {
                      var mov =  state.nowplaying[index];
                      var image = mov.posterPath;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Image.network('https://image.tmdb.org/t/p/w300${mov.posterPath}'),),
                      );
                       
                     },),
                  )
                ],
              ),
            );
          } else if (state is StateLoading) {
            return Column(
              children: [
                Container(
                  height: 30,
                  width: 200,
                  color: Colors.blue.shade900,
                )
              ],
            );
          }else if(state is StateError){
          return Container(child: Center(child: Text(
            textAlign: TextAlign.center,
            'Something went Wrong ${state.e}', style: TextStyle(
            
            color: Colors.white),))); //  
          }
          return Container(child: Text('YOu got me')); //  
        },
      ),
    );
  }
}
