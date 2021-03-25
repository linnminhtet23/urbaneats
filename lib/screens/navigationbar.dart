import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:urban_eats/screens/chatbot.dart';
import 'package:urban_eats/screens/feed.dart';
import 'package:urban_eats/screens/profile.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  final Feed _feeds = new Feed();
  final Chatbot _chatbot = new Chatbot();
  final Profile _profile = new Profile();

  Widget _showPage = new Feed();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _feeds;
        break;
      case 1:
        return _chatbot;
        break;
      case 2:
        return _profile;
        break;
      default:
        return new Container(
            child: new Center(
                child: new Text("No Page Found",
                    style: new TextStyle(fontSize: 30))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          initialIndex: pageIndex,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.explore, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              _showPage = _pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPage,
          ),
        ));
  }
}
