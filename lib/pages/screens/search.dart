import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/state/bloc/search/search_bloc.dart';
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
        centerTitle: true, title: MyText(text: 'Search',  fnweight: FontWeight.bold,),
     
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(
                color: Colors.white
              ),
              controller: controllerText,
              onSubmitted: (value) {
                print('value: $value');
                print('controller: $controllerText');
                context.read<SearchBloc>().add(Searching(querySeacrhing: value));
              },
            ),
          ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if(state is SearchLoaded){return SizedBox(
                  height: 580,
                  child: ListView.builder(
                    itemCount: state.searching.length,
                    itemBuilder: (context, index) {
                      var mov = state.searching[index];
                      return ListTile(
                      title: MyText(text:mov.title),
                      );
                  },),
                );}
                return Container();
          },
        )
        ],
      ),
    );
  }
}