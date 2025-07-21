import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
ScrollController _scrollController = ScrollController();
int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(text: 'Search',  fnweight: FontWeight.bold,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(

          )
        ],
      ),
    );
  }
}