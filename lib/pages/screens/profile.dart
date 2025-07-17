import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: MyText(text: 'Profile', fnSize: 18,fnweight: FontWeight.bold,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           SizedBox(   
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 80, width: 80, decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 41, 41, 40),
                  borderRadius: BorderRadius.circular(30),
                  border: BoxBorder.all(
                    width: 0.5,
                    color: Colors.grey.shade700
                  ),
                  boxShadow:const [
                    BoxShadow(
                      offset: Offset(5, 5),
                      color: Color.fromARGB(80, 122, 122, 122),
                      blurRadius: 10
                    ),
                  ] ,
                  ),
                  
                 child: const Icon(Icons.person,size: 50,), ),
                 MyText(text: 'Username', fnweight: FontWeight.bold, clors: Colors.grey.shade500, fnSize: 12,)
              ],
            ),
           ),
          Container(
            color: Colors.red,
        width:  width * 0.85,
        height: 50,
          )
          
          ],
        ),
      ),
    );
  }
}