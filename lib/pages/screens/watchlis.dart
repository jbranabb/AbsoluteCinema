import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

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
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
           itemCount: state.dataWatchlist.length,
           itemBuilder:(context, index) {
             return Container(
              color: Colors.amber,
              height: 10,
              width: 20,
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