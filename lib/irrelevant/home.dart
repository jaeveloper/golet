import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _myPage = PageController(initialPage: 0);

  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Title(
          color: Colors.white,
          child: Image.asset(
            'assets/inhabitants_logo.png',
            scale: 8,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          ),
          InkWell(
            onTap: null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        
        // elevation: 20.0,

        child: Container(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 12,
                  right: MediaQuery.of(context).size.width / 12,
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.grey.shade700,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 12,
                  right: MediaQuery.of(context).size.width / 12,
                ),
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.grey.shade700,
                  semanticLabel: 'aaa',
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                    print("$_currentIndex");
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 12,
                  right: MediaQuery.of(context).size.width / 12,
                ),
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.grey.shade700,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                    print("$_currentIndex");
                    _myPage.jumpToPage(2);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 12,
                  right: MediaQuery.of(context).size.width / 12,
                ),
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.grey.shade700,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                    print("$_currentIndex");
                    _myPage.jumpToPage(3);
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (int) {
          print('Page Changes to index $int');
        },
        children: <Widget>[
          Center(
            child: Container(
              child: Text('Empty Body 0'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 1'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 2'),
            ),
          ),
          Center(
            child: Container(
              child: Text('Empty Body 3'),
            ),
          )
        ],
        physics:
            NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
    );
  }
}
