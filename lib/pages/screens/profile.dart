import 'package:absolutecinema/main.dart';
import 'package:absolutecinema/pages/screens/auth_page.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/state/bloc/auth/auth_bloc.dart';
import 'package:absolutecinema/state/bloc/dataUser/data_user_bloc.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Uri url = Uri.parse('https://www.themoviedb.org/settings/profile');

Future<void> _launchUrl() async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserCredentials(mediaType: 'movies'));
  }

  @override
  Widget build(BuildContext context) {
    int? values;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      displacement: 20,
      onRefresh: () async {
        context.read<DataUserBloc>().add(FetchDataUser());
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: MyText(
            text: 'Profile',
            fnSize: 18,
            fnweight: FontWeight.bold,
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Movies'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Tv Shows'),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  print(value);
                  values != value
                      ? context
                          .read<UserBloc>()
                          .add(UserCredentials(mediaType: 'movies'))
                      : null;
                } else {
                  values != value
                      ? context
                          .read<UserBloc>()
                          .add(UserCredentials(mediaType: 'tv'))
                      : null;
                }
                values = value;
              },
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 120,
              child: BlocBuilder<DataUserBloc, DataUserState>(
                builder: (context, state) {
                  if (state is DataUserLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 41, 41, 40),
                              borderRadius: BorderRadius.circular(30),
                              border: BoxBorder.all(
                                  width: 0.5, color: Colors.grey.shade700),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(5, 5),
                                    color: Color.fromARGB(80, 122, 122, 122),
                                    blurRadius: 10),
                              ],
                            ),
                            child: state.profilePath == ''
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      imageUrl: state.profilePath,
                                      fit: BoxFit.cover,
                                    )),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          text: state.username,
                          fnweight: FontWeight.bold,
                          clors: Colors.grey.shade500,
                          fnSize: 12,
                        )
                      ],
                    );
                  } else if (state is DataUserLoading) {
                    return Container(
                      height: 80,
                      width: 80,
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // wacthlist | favorite | Ratings
            Container(
              width: width * 0.90,
              height: 100,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      BoxBorder.all(width: 0.7, color: Colors.grey.shade900)),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserDataLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        UserCrendialsContainer(
                          length: state.dataWatchlist.length,
                          title: 'Watchlist',
                        ),
                        UserCrendialsContainer(
                          length: state.dataFav.length,
                          title: 'Favorite',
                        ),
                        UserCrendialsContainer(
                          length: state.dataRated.length,
                          title: 'Ratings',
                        ),
                      ],
                    );
                  } else if (state is UserLoading) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyText(
                    text: "Favorite",
                    fnweight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: height * 0.18,
              width: width * 0.95,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserDataLoaded) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, childAspectRatio: 9 / 13),
                      shrinkWrap: true,
                      itemCount: state.dataFav.take(4).length,
                      itemBuilder: (context, index) {
                        var mov = state.dataFav[index];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey.shade800,
                                    strokeAlign: 1)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w780${mov.posterPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is UserLoading) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  } else if (state is UserFailed) {
                    Center(
                      child: MyText(text: 'Something Went Wrong \n ${state.e}'),
                    );
                  }
                  return Container();
                },
              ),
            ),
            UserMenuTap(
              title: 'Edit Profile',
              icons: Icons.edit_square,
              callback: () async {
                try {
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: LoadingWidget(),
                    ),
                  );
                  Navigator.of(context).pop();
                  await _launchUrl();
                } catch (e) {}
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is AuthInitial) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthPage(),
                  ));
                  pref?.remove('sessionId');
                  print('udah hapus : ${pref?.getString('sessionId')}');
                }
              },
              child: UserMenuTap(
                title: 'Log Out',
                colors: Colors.red.shade800,
                icons: Icons.logout,
                callback: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 8, 8, 8),
                      title: MyText(
                        text: 'Wait, Leaving Already?',
                        fnweight: FontWeight.bold,
                      ),
                      content: MyText(
                        text: 'You’re about to log out. Wanna go ahead?',
                        maxlines: 2,
                      ),
                      actions: [
                        ActionButtton(
                          callback: () => Navigator.of(context).pop(),
                          title: 'Nope',
                        ),
                        ActionButtton(
                          callback: () =>
                              context.read<AuthBloc>().add(AuthlogOut()),
                          title: 'Okayy',
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtton extends StatelessWidget {
  ActionButtton({
    super.key,
    required this.callback,
    required this.title,
  });
  void Function() callback;
  String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callback,
      style: TextButton.styleFrom(backgroundColor: Colors.white,),
      child: MyText(
        text: title,
        clors: Colors.black,
        fnweight: FontWeight.w600,
      ),
    );
  }
}

class UserMenuTap extends StatelessWidget {
  UserMenuTap({
    super.key,
    required this.title,
    this.colors,
    required this.icons,
    required this.callback,
  });
  String title;
  IconData? icons;
  Color? colors;
  void Function() callback;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: callback,
        child: Container(
          height: 40,
          width: width * 0.90,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 22, 22, 22).withOpacity(0.4),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: title,
                  fnweight: FontWeight.bold,
                  clors: colors != null ? colors : Colors.grey.shade200,
                ),
                Icon(
                  icons,
                  color: colors != null ? colors : Colors.grey.shade200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserCrendialsContainer extends StatelessWidget {
  UserCrendialsContainer(
      {super.key, required this.title, required this.length});
  String title;
  int length;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      width: width * 0.23,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 22, 22, 22).withOpacity(0.4),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyText(
            text: '$length',
            fnSize: 25,
            fnweight: FontWeight.bold,
            clors: Colors.grey.shade400,
          ),
          MyText(
            text: title,
            fnSize: 12,
            fnweight: FontWeight.bold,
            clors: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
