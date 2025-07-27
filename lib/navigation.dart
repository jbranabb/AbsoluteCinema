import 'package:absolutecinema/pages/screens/credentials_page.dart';
import 'package:absolutecinema/pages/screens/home_page.dart';
import 'package:absolutecinema/pages/screens/profile.dart';
import 'package:absolutecinema/pages/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
    int currentIndex = 0;
    List<Widget> _pages(){
      return[
        HomePage(),
        SearchPage(),
        CredentialsPage(),
        ProfilePage()
      ];
    }
    List<SalomonBottomBarItem> _navItems(){
      return [
        SalomonBottomBarItem(icon:Icon(Icons.home) , title: Text('Home'), selectedColor: Colors.blue, unselectedColor: Colors.grey.shade400,),
        SalomonBottomBarItem(icon:Icon(Icons.search) , title: Text('Search'), selectedColor: Colors.blue, unselectedColor: Colors.grey.shade400,),
        SalomonBottomBarItem(icon:Icon(Icons.bookmark) , title: Text('Library'), selectedColor: Colors.blue, unselectedColor: Colors.grey.shade400,),
        SalomonBottomBarItem(icon:Icon(Icons.person) , title: Text('Profile'), selectedColor: Colors.blue, unselectedColor: Colors.grey.shade400,),
      ];
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages()[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items:_navItems()),
    );
}}
