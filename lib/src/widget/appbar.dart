import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  String title ;
  bool leadingbtn ;
  bool actionbtn;
  bool drawer;
  CustomAppbar({this.actionbtn=false ,this.title , this.leadingbtn=false,this.drawer=false ,Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      centerTitle: true,
      backgroundColor: primaryBtnColor,
      automaticallyImplyLeading: leadingbtn,
      leading: leadingbtn ? drawer ? IconButton(
          icon: Icon(Icons.gamepad,color: Colors.yellow,),
          onPressed: (){
            //openDrawer();
          },
        ) : Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.arrow_back_ios,color:white100,),
            onPressed: () { 
              Navigator.of(context).pop();
              },
            );
          },
        )
        : Container() ,
      title: Text(title ,style: Styles.whiteTextwithf20w6,),
      actions: <Widget>[
        actionbtn ? 
//        IconButton(
//          icon: Icon(Icons.folder,color: grey100,size: 30.0,),
//          onPressed: (){
//            Navigator.pushNamed(context, screen,arguments: {'screenid':1});
//          },
//          )
        IconButton(
          icon: Icon(Icons.notifications,color:grey100,size: 30.0,),
          onPressed: () {
            Navigator.pushNamed(context, notification);
          },
        )
        :SizedBox(width:2.0),
        SizedBox(width:20.0)
      ],
    );
  }
}
