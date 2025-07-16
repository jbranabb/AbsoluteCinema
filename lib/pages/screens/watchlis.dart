import 'package:absolutecinema/apiService/service.dart';
import 'package:absolutecinema/pages/screens/detail.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({
    super.key,
  });

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

var moviesMediatype = 'movies';

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserCredentials(mediaType: moviesMediatype));
  }

  @override
  Widget build(BuildContext context) {
    var tvMediatype = 'tv';
    int? values;
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: 'Watchlist',
          fnweight: FontWeight.bold,
          fnSize: 18,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 2) {
                values != value
                    ? context
                        .read<UserBloc>()
                        .add(UserCredentials(mediaType: tvMediatype))
                    : null;
              } else {
                values != value
                    ? context
                        .read<UserBloc>()
                        .add(UserCredentials(mediaType: moviesMediatype))
                    : null;
              }
              values = value;
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Movies'),
                value: 1,
              ),
              const PopupMenuItem(
                child: Text('Tv Show'),
                value: 2,
              ),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print(values);
          if (values == 2) {
            context
                .read<UserBloc>()
                .add(UserCredentials(mediaType: tvMediatype));
          print('ha');
          }else{

          context
              .read<UserBloc>()
              .add(UserCredentials(mediaType: moviesMediatype));
          print('hi');
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserDataLoaded) {
              if (state.dataWatchlist.isEmpty) {
                return const Center(
                  child: Text('Empty Bucket bro..\nadding something here'),
                );
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 3 / 4),
                  itemCount: state.dataWatchlist.length,
                  itemBuilder: (context, index) {
                    // state.dataWatchlist.co
                    var movies = state.dataWatchlist[index];
                    return GestureDetector(
                      onTap: () async {
                        var mediatypeValue = values == 2 ? 'tv' : 'movie';
                        final currentContext = context;
                        showDialog(
                          context: currentContext,
                          builder: (context) =>
                              const Center(child: LoadingWidget()),
                        );
                        var extra = await extraData(
                            int.parse(movies.id), mediatypeValue);

                        try {
                          if (!mounted) return;
                          Navigator.of(currentContext)
                              .pop(); // tutup loading dialog

                          if (!mounted) return;
                          Navigator.of(currentContext).push(MaterialPageRoute(
                            builder: (context) => DetailPage(
                              key: UniqueKey(),
                              oveview: movies.overview,
                              titile: movies.title,
                              backdropImage: movies.backdropPath,
                              posterImage: movies.posterPath,
                              genreNames: movies.genreIds.join(', '),
                              date: movies.relaseDate,
                              voteAvg: movies.voteAvg,
                              country: extra['country'],
                              director: extra['director'],
                              runtime: extra['rtns'],
                              tagline: extra['tagline'],
                              ytkey: extra['ytkey'],
                              id: int.parse(movies.id),
                              mediatype: mediatypeValue,
                            ),
                          ));
                        } catch (e) {
                          if (!mounted) return;
                          Navigator.of(currentContext)
                              .pop(); // tutup loading dialog

                          if (!mounted) return;
                          showDialog(
                            context: currentContext,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Sorry Something Went Wrong',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Text(
                                e.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(currentContext).pop(),
                                    child: const Text('Close'))
                              ],
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                              border: BoxBorder.all(
                                  color: Colors.blueGrey,
                                  style: BorderStyle.solid,
                                  width: 0.5,
                                  strokeAlign: 1)),
                          child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w780${movies.posterPath}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                       movies.title, textAlign: TextAlign.center, style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800
                                       ),),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.help),
                                ),
                              )),
                        ),
                      ),
                    );
                  });
            } else if (state is UserLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is UserFailed) {
              return Center(
                child: MyText(text: state.e),
              );
            }
            return Container(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
