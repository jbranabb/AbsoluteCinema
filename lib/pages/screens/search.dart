import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
ScrollController _scrollController = ScrollController();
int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: 100,
        itemBuilder: (context, index) {
          if(_scrollController.offset > 50){
            print(page++);
            }
          // print(_scrollController);
        return Container(
          height: 200,
          child: Center(
            child: Text('Section $index'),
          ),
        );
      },),
    );
  }
}