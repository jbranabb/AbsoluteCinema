import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: MyText(text: 'Profile', fnSize: 18,fnweight: FontWeight.bold,),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         SizedBox(   
          height: 120,
          child: Center(
            child: Container(height: 80, width: 80, decoration: BoxDecoration(
              color: const Color.fromARGB(255, 41, 41, 40),
              borderRadius: BorderRadius.circular(30),
              border: BoxBorder.all(
                width: 0.5,
                color: Colors.blueGrey
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
          ),
         ),
    
        
        ],
      ),
    );
  }
}