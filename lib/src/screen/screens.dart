import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/screen/notification/notification.dart';
import 'package:housepital/src/widget/bottomnavigation.dart';
import 'package:flutter/material.dart';

import 'history/history.dart';
import 'home/Home.dart';
import 'profile/profile.dart';
import 'purchase/purchase.dart';

class Screens extends StatefulWidget {
  Map screen ;
  Screens(this.screen);
  @override
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  final navigatorKey = GlobalKey<NavigatorState>();

  int _currentIndex = 0 ;
  final List<Widget> _children = [
   Home() ,
   NotificationPage(),
   History() ,
   Profile(),
   Purchase()
 ];

  PageController _pageController ;

  @override
  void initState() {
    
    _currentIndex = widget.screen['screenid'] ;
    //_pageController = PageController(initialPage: _currentIndex,keepPage: false);
    super.initState();

  }

  @override
  void dispose() {
    //_pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      // _pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 100), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: greybarBackgroundColor,
        currentIndex: _currentIndex,
        elevation: 20.0,
        onTap: onTabTapped ,
        selectedItemColor: primaryColor,
        unselectedItemColor: black50,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: buildNavigationItems(),
        iconSize: 28.0,
        type: BottomNavigationBarType.fixed,
      ),
      body: _children[_currentIndex]
      // SizedBox.expand(
      //   child: PageView(
      //     physics: NeverScrollableScrollPhysics(),
      //     onPageChanged: (index) {
      //       setState(() => _currentIndex = index);
      //     },
      //     children: <Widget>[
      //       Container(child: Home(),),
      //       //Container(child: Library(),),
      //       Container(child: Donate()),
      //       Container(child: NotificationPage(),),
      //       Container(child: Profile(),),
      //     ],
      //   ),
      // ),
    );
  }
}