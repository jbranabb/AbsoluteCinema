import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
   WatchlistPage({super.key,});

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
      appBar:AppBar(
        title: MyText(text: 'Watchlist'),
        centerTitle: true,
      ) ,
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if(state is UserDataLoaded){
          if(state.dataWatchlist.isEmpty){
            return Center(child: Text('Data kosong bro'),);
          }
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4
          ,childAspectRatio: 3 / 4),
           itemCount: state.dataWatchlist.length,
           itemBuilder:(context, index) {
            var movies = state.dataWatchlist[index];
             return Padding(
               padding: const EdgeInsets.all(2.0),
               child: Container(
                color: Colors.amber,
                child: CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/w780${movies.posterPath}'),
               ),
             );
           });
        }else  if(state is UserLoading){
          return Center(
            child: LoadingWidget(),
          );
        }else if(state is UserFailed){
          return Center(
            child: MyText(text: state.e),
          );
        }
        return Container(
          color: Colors.red,
        );
      },),
    );
  }
}