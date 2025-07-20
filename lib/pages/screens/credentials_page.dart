import 'package:absolutecinema/pages/screens/watchlis.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CredentialsPage extends StatefulWidget {
  const CredentialsPage({super.key});

  @override
  State<CredentialsPage> createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserCredentials(mediaType: moviesMediatype));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:  MyText(text: 'Library', fnweight: FontWeight.bold,fnSize: 20,),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 44, 44, 44)),
                  height: 40,
                  width: width * 0.90,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    dividerHeight: 0,
                    splashBorderRadius: BorderRadius.circular(10),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w500),
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsetsGeometry.symmetric(
                        horizontal: 5, vertical: 6),
                    tabAlignment: TabAlignment.fill,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54),
                    tabs: const [
                      Text('Watchlist'),
                      Text('Favorites'),
                      Text('Rated'),
                    ],
                  ),
                ),
              )),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserDataLoaded) {
              return TabBarView(children: [
                WatchlistPage(
                  title: 'Watchlist',
                  list: state.dataWatchlist,
                ),
                WatchlistPage(title: 'Favorite', list: state.dataFav),
                WatchlistPage(title: 'Rated', list: state.dataRated),
              ]);
            } else if (state is UserLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is UserFailed) {
              return Center(
                child: MyText(text: state.e),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
