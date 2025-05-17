import 'package:absolutecinema/state/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if(state is StateLoaded){
                return SizedBox(
                  height: 200,
                  child: Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                      itemCount: state.list.length,
                      itemBuilder:(context, index) {
                      final movData = state.list[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              child: Image.network('https://image.tmdb.org/t/p/w500${movData.posterPath}'),
                              color: Colors.red
                            ),
                          ],
                        ),
                      );
                    },),
                  ),
                );
              }else if(state is StateError){
                return Center(child: Text(state.e),);
              }else if(state is StateLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              return Container();
            },
          ),
        ],
      )
    );
  }
}