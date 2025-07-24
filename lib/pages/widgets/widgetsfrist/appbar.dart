import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/state/bloc/dataUser/data_user_bloc.dart';
import 'package:absolutecinema/state/bloc/user/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({
    super.key,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  void initState() {
    super.initState();
    context.read<DataUserBloc>().add(FetchDataUser());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                BlocBuilder<DataUserBloc, DataUserState>(
                  builder: (context, state) {
                    if(state is DataUserLoaded){return Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white60),
                            color: Colors.grey.shade600.withOpacity(0.6),
                          ),
                          child: state.profilePath == '' ? const Icon(Icons.person) : ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(30),
                            child: CachedNetworkImage(imageUrl: state.profilePath, fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                    );}
                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 11.0, top: 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good Morning',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                      BlocBuilder<DataUserBloc, DataUserState>(
                        builder: (context, state) {
                          if (state is DataUserLoaded) {
                            return Text(
                              state.username,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                          return const Text(
                            '!Hi User',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, right: 20),
              child: Row(
                children: [
                  MyText(text: 'Absolute', fnweight: FontWeight.bold,clors: Colors.blue.shade900,),
                  MyText(text: 'Cinema', fnweight: FontWeight.bold,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
