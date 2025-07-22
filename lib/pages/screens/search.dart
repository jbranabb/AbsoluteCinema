import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/state/bloc/search/search_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController controllerText = TextEditingController();
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyText(
          text: 'Search',
          fnweight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: controllerText,
                onSubmitted: (value) {
                  print('value: $value');
                  print('controller: $controllerText');
                  context
                      .read<SearchBloc>()
                      .add(Searching(querySeacrhing: value));
                },
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return Container(height: 200, color: Colors.red);
                }
                if (state is SearchLoaded) {
                  return SizedBox(
                    height: 580,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, mainAxisExtent: 150),
                      itemCount: state.searching.length,
                      itemBuilder: (context, index) {
                        var mov = state.searching[index];
                        return Container(
                          // color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 140,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.blueGrey, width: 0.5)),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadiusGeometry.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w300${mov.posterPath}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 120,
                                  width: 200,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: mov.title,
                                        fnweight: FontWeight.bold,
                                      ),
                                      Text(
                                        mov.genreIds.join(', '),
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 120,
                                        // color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            MyText(
                                              text: mov.relaseDate
                                                  .substring(0, 4),
                                              fnweight: FontWeight.w700,
                                            ),
                                            MyText(
                                              text: '•',
                                              fnweight: FontWeight.w800,
                                              clors: Colors.grey.shade500,
                                            ),
                                            MyText(
                                              text: 'DIRECTED BY',
                                              clors: Colors.grey.shade600,
                                              fnSize: 11,
                                              fnweight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                      MyText(
                                        text: mov.director,
                                        fnweight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
