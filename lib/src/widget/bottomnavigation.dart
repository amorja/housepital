import 'package:flutter/material.dart';

    List<BottomNavigationBarItem> buildNavigationItems() {
    return <BottomNavigationBarItem>[
        BottomNavigationBarItem(
              icon: new Image.asset('lib/assets/icons/star.png',width: 28.0,),
              title: new Text('Service',)
            ),
            BottomNavigationBarItem(
              icon: new Image.asset('lib/assets/icons/notification.png',width: 28.0,),
              title: new Text('Notification',)
            ),
            BottomNavigationBarItem(
              icon: new Image.asset('lib/assets/icons/history.png',width: 28.0,),
              title: new Text('History',)
            ),
            BottomNavigationBarItem(
              icon: new Image.asset('lib/assets/icons/user_whitecircle.png',width: 28.0,),
              title: new Text('Profile',)
            ),
            BottomNavigationBarItem(
              icon: new Image.asset('lib/assets/icons/cart.png',width: 28.0,),
              title: new Text('Purchase',),
              activeIcon: new Image.asset('lib/assets/icons/cart.png',width: 28.0,),
            ),
         ];
      }