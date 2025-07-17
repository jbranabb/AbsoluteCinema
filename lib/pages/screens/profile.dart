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
        title: MyText(
          text: 'Profile',
          fnSize: 18,
          fnweight: FontWeight.bold,
        ),
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
                  Container(
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
                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyText(
                    text: 'Username',
                    fnweight: FontWeight.bold,
                    clors: Colors.grey.shade500,
                    fnSize: 12,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // wacthlist | favorite | Ratings
            Container(
              width: width * 0.85,
              height: 100,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      BoxBorder.all(width: 0.7, color: Colors.grey.shade900)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  UserCrendialsContainer(
                    title: 'Watchlist',
                  ),
                  UserCrendialsContainer(
                    title: 'Favorite',
                  ),
                  UserCrendialsContainer(
                    title: 'Ratings',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            
            UserMenuTap(title: 'Edit Profile', icons: Icons.edit_square,),
            UserMenuTap(title: 'Log Out', colors: Colors.red.shade800, icons: Icons.logout,),
          
          ],
        ),
      ),
    );
  }
}

class UserMenuTap extends StatelessWidget {
  UserMenuTap({
    super.key,
    required this.title,
    this.colors,
    required  this.icons,
  });
  String title;
  IconData? icons;
  Color? colors;

 
  @override
  Widget build(BuildContext context) {
    var width =  MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              MyText(text: title,fnweight: FontWeight.bold,clors: colors != null ? colors : Colors.grey.shade200, ),
              Icon(icons, color: colors != null ? colors : Colors.grey.shade200,)
            ],
          ),
        ),
      ),
    );
  }
}

class UserCrendialsContainer extends StatelessWidget {
  UserCrendialsContainer({super.key, required this.title});
  String title;

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
            text: '0',
            fnSize: 25,
            fnweight: FontWeight.bold,
            clors: Colors.grey.shade700,
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
