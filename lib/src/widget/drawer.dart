import 'package:flutter/material.dart';
import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/routes/route_const.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: new Image.asset('lib/assets/icons/star.png',width: 28.0,),
              text: 'Services',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, screen,arguments: {'screenid':0});
              }
            ),
          _createDrawerItem(
              icon: new Image.asset('lib/assets/icons/notification.png',width: 28.0,),
              text: 'Notification',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, screen,arguments: {'screenid':1});
              }
            ),
          _createDrawerItem(
              icon: new Image.asset('lib/assets/icons/history.png',width: 28.0,),
              text: 'History',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, screen,arguments: {'screenid':2});
              }
            ),
          _createDrawerItem(icon: new Image.asset('lib/assets/icons/user_whitecircle.png',width: 28.0,), text: 'Profile',
            onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, screen,arguments: {'screenid':3});
              }
            ),
          _createDrawerItem(icon: new Image.asset('lib/assets/icons/cart.png',width: 28.0,), text: 'Purchase',
            onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, screen,arguments: {'screenid':4});
              }
            ),
          Divider(),
          //_createDrawerItem(icon: Icons.settings, text: 'Setting'),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      
      child: Container(
        decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: grey77)) ,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('lib/assets/logo/logo.png'))),
      ),
    );
  }

  Widget _createDrawerItem(
      {Image icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon,
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,style: Styles.blackopacity5f18,),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}