import 'package:absolutecinema/pages/screens/credentials_page.dart';
import 'package:absolutecinema/pages/screens/home_page.dart';
import 'package:absolutecinema/pages/screens/profile.dart';
import 'package:absolutecinema/pages/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _mainScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(10),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _mainScreens() {
    return [
      HomePage(),
      SearchPage(),
      CredentialsPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.blue.shade900,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: 'Search',
        activeColorPrimary: Colors.blue.shade900,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.bookmark),
        title: 'Library',
        activeColorPrimary: Colors.blue.shade900,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: 'Profile',
        activeColorPrimary: Colors.blue.shade900,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
