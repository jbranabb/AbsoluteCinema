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

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserCredentials(mediaType: 'movies'));
  }

  @override
  Widget build(BuildContext context) {
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
                context.read<UserBloc>().add(UserCredentials(mediaType: 'tv'));
              } else {
                context
                    .read<UserBloc>()
                    .add(UserCredentials(mediaType: 'movies'));
              }
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
      body: BlocBuilder<UserBloc, UserState>(
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
                  var movies = state.dataWatchlist[index];
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: BoxBorder.all(
                              color: Colors.blueGrey,
                              style: BorderStyle.solid,
                              width: 1.0)),
                      child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(5),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w780${movies.posterPath}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: MyText(
                                text: movies.title,
                                fnweight: FontWeight.bold,
                                fnSize: 11,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.help),
                            ),
                          )),
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
    );
  }
}
