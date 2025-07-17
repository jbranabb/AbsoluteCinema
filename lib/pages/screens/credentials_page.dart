import 'package:flutter/material.dart';

class CredentialsPage extends StatelessWidget {
  const CredentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          title: Text('Credentials'),
        bottom: PreferredSize(preferredSize: Size.fromHeight(30), child: ClipRRect(
          
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
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 6),
              tabAlignment: TabAlignment.fill,
               indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                            
            
              tabs: [
              Text('data'),
              Text('data'),
              Text('data'),
            ],),
          ),
        )),
        ),
        body: TabBarView(
          children: [
          Text('data 1'),
          Text('data 2'),
          Text('data 3'),
          ]),
      ),
    );
  }
}