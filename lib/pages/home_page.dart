import 'package:absolutecinema/pages/detail.dart';
import 'package:absolutecinema/state/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      body: Column(
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
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is StateLoaded) {
                return Container(
                  height: 250,
                  child: GridView.builder(
                    itemCount: state.list.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 2.0,
                        mainAxisExtent: 150),
                    itemBuilder: (context, index) {
                      var mov = state.list[index];
                      var title = state.list[index].title;
                      var image = state.list[index].posterPath;
                      var overview = state.list[index].overview;
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(
                            overview: overview,
                            image:image, title: title,)));  
                            
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
                );
              } else if (state is StateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(child: Text('YOu got me'));
            },
          )
        ],
      ),
    );
  }
}
