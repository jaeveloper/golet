import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:golet/models/user_data.dart';
import 'package:golet/screens/HomeScreen.dart';
import 'package:golet/screens/favorite.dart';
import 'package:golet/screens/create_post_screen.dart';
import 'package:golet/screens/profilepage.dart';
import 'package:golet/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  PageController _pageController;
  @override
  void initState() {
    
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserData>(context).currentUserId);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePgeScreen(),
          SearchScreen(),
          CreatePostScreen(),
          Favorite(),
          ProfilePage(userId: Provider.of<UserData>(context).currentUserId),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          /*_pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          ); */
          _pageController.jumpToPage(index);
        },
        activeColor: Colors.blue.shade700,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
