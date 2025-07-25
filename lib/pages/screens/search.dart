import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/main.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/state/bloc/search/search_bloc.dart';
import 'package:absolutecinema/state/cubit/textController_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controllerText = TextEditingController();

  List<String> historyList = pref?.getStringList('mykey') ?? [];

  int page = 1;
  @override
  void initState() {
    super.initState();
    context.read<TextcontrollerCubit>().updateText(controllerText.text);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop == true) {
          context.read<SearchBloc>().add(Reset());
        }
      },
      child: Scaffold(
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: BlocBuilder<TextcontrollerCubit, String>(
                        builder: (context, state) {
                          return TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: controllerText,
                            onChanged: (value) {
                              context
                                  .read<TextcontrollerCubit>()
                                  .updateText(value);
                            },
                            onSubmitted: (value) async {
                              if (state.isNotEmpty) {
                                context
                                    .read<SearchBloc>()
                                    .add(Searching(querySeacrhing: value));
                                historyList.add(value);
                                await pref?.setStringList('mykey', historyList);
                                if(historyList.length > 5){
                                  historyList.removeAt(0);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   const SnackBar(content: Text('Harus di isi')));
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade900,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                filled: true,
                                hintText: 'Search',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w700),
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: state.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          controllerText.clear();
                                          print(
                                              'text : ${controllerText.text.length}');
                                        },
                                        icon: Icon(
                                          Icons.clear_rounded,
                                          color: Colors.grey.shade700,
                                        ))
                                    : null,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  var history = pref?.getStringList('mykey') ?? [];
                  var take = history!.reversed.take(5).toList();
                  if (state is SearchInitial) {
                    return Column(
                      children: [
                        take.isNotEmpty
                            ? Container(
                                height: 40,
                                width: width,
                                // color: Colors.red,
                                child: SingleChildScrollView( 
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                        take.length,
                                        (index) {
                                          var list = take[index];
                                          return GestureDetector(
                                            onTap: () {
                                              context.read<TextcontrollerCubit>().updateText(list);
                                              controllerText.text = list;
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade800)),
                                                child: MyText(
                                                  text: list,
                                                  fnSize: 13,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )))
                            : Container(
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MyText(
                                  text: 'Trending right now',
                                  fnweight: FontWeight.bold,
                                  fnSize: 15,
                                ),
                              ),
                              Container(
                                height: height * 0.75,
                                // color: Colors.red,
                                child: BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    if (state is StateLoaded) {
                                      var list =
                                          state.allShows.take(9).toList();
                                      return GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: list.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisExtent: 180,
                                        ),
                                        itemBuilder: (context, index) {
                                          var mov = list[index];
                                          return GestureDetector(
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) => Center(
                                                  child: LoadingWidget(),
                                                ),
                                              );
                                              try {
                                                var extra = await extraData(
                                                    int.parse(mov.id),
                                                    mov.mediatype);
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                    voteAvg: mov.voteAvg,
                                                    date: mov.relaseDate,
                                                    oveview: mov.overview,
                                                    titile: mov.title,
                                                    backdropImage:
                                                        mov.backdropPath,
                                                    posterImage: mov.posterPath,
                                                    genreNames:
                                                        mov.genreIds.join(', '),
                                                    id: int.parse(mov.id),
                                                    mediatype: mov.mediatype,
                                                    country: extra['country'],
                                                    director: extra['director'],
                                                    runtime: extra['rtns'],
                                                    tagline: extra['tagline'],
                                                    ytkey: extra['ytkey'],
                                                  ),
                                                ));
                                              } catch (e) {
                                                if (!mounted) return;
                                                Navigator.of(context).pop();

                                                if (!mounted) return;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                      'Sorry Something Went Wrong',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: Text(
                                                      e.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: const Text(
                                                              'Close'))
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 100,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color:
                                                              Colors.blueGrey,
                                                          width: 0.5)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadiusGeometry
                                                            .circular(10),
                                                    child: mov.posterPath ==
                                                                'noPosterpPath' ||
                                                            mov.posterPath == ''
                                                        ? Container(
                                                            color: Colors.grey,
                                                            child: Icon(Icons
                                                                .error_outline),
                                                          )
                                                        : CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                'https://image.tmdb.org/t/p/w300/${mov.posterPath}',
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                              color:
                                                                  Colors.grey,
                                                              child: Icon(Icons
                                                                  .error_outline),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (state is StateLoading) {
                                      return Center(
                                        child: LoadingWidget(),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                              ),
                              Container(
                                height: 20,
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (state is SearchLoading) {
                    return Center(
                      child: LoadingWidget(),
                    );
                  }
                  if (state is SearchLoaded) {
                    if (state.searching.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Icon(
                            Icons.movie_sharp,
                            size: 50,
                          ),
                          MyText(
                            text:
                                " No matches found for '${controllerText.text}'. Try a different keyword!",
                            maxlines: 3,
                          )
                        ],
                      );
                    }
                    return SizedBox(
                      height: height * 0.77,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, mainAxisExtent: 150),
                        itemCount: state.searching.length,
                        itemBuilder: (context, index) {
                          var mov = state.searching[index];
                          return GestureDetector(
                                 onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) => Center(
                                                  child: LoadingWidget(),
                                                ),
                                              );
                                              try {
                                                var extra = await extraData(
                                                    int.parse(mov.id),
                                                    mov.mediatype);
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                    voteAvg: mov.voteAvg,
                                                    date: mov.relaseDate,
                                                    oveview: mov.overview,
                                                    titile: mov.title,
                                                    backdropImage:
                                                        mov.backdropPath,
                                                    posterImage: mov.posterPath,
                                                    genreNames:
                                                        mov.genreIds.join(', '),
                                                    id: int.parse(mov.id),
                                                    mediatype: mov.mediatype,
                                                    country: extra['country'],
                                                    director: extra['director'],
                                                    runtime: extra['rtns'],
                                                    tagline: extra['tagline'],
                                                    ytkey: extra['ytkey'],
                                                  ),
                                                ));
                                              } catch (e) {
                                                if (!mounted) return;
                                                Navigator.of(context).pop();

                                                if (!mounted) return;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                      'Sorry Something Went Wrong',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    content: Text(
                                                      e.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: const Text(
                                                              'Close'))
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
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
                                            color: Colors.blueGrey,
                                            width: 0.5)),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: mov.posterPath.isNotEmpty
                                            ? 'https://image.tmdb.org/t/p/w300${mov.posterPath}'
                                            : 'https://critics.io/img/movies/poster-placeholder.png',
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
      ),
    );
  }
}
