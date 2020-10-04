import 'dart:io';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/font_sizes.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/screen/home/webViewPage.dart';
import 'package:housepital/src/screen/profile/profileedit.dart';
import 'package:housepital/src/utils/database_helper.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:housepital/src/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final dbHelper = DatabaseHelper.instance;
  bool _isleading = false ;
  String title= 'My Profile';
  String name ='';
  String email = '';
  int indexno = 10 ;
  bool _isprofileEdit = false ;
  bool _ispasswordedit=false ;
  List<String> profileList = [
    "Category",
    "About",
    "Terms and Conditions",
    "Logout",
  ];
  read() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email= prefs.getString('username');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    read();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _isleading 
            ? Navigator.pushNamed(context, screen,arguments: {'screenid':2})
            : (await showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Are you sure?'),
                    content: new Text('Do you want to exit an App'),
                    actions: <Widget>[
                      new FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: new Text('No'),
                      ),
                      new FlatButton(
                        onPressed: () => exit(0),
                        child: new Text('Yes'),
                      ),
                    ],
                  ),
                )) ??
                false;
      } ,
      child: _isprofileEdit ? ProfileEdit() : 
       Scaffold(
        backgroundColor: greyBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: primaryBtnColor,
            title: Text('Profile',style: Styles.whiteTextwithf20w6,),
          ),
        ),
        drawer: AppDrawer(),
        body: layout()
        // indexno == 9 ? SavedResource() :
        //   indexno == 0 ? Category() :
        //   profile()
      ),
    );
  }
  Widget layout(){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            container1('lib/assets/images/profile.jpg','Ajay Kumar'),
            //SizedBox(height:8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Age - 23',style: Styles.blackopacity5f18,),
                        Text('Address - Dwarka Sec. 8',style: Styles.blackopacity5f18,)
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: RaisedButton(
                        elevation: 0,
                        child: Text("Edit",style: TextStyle(color: downloadbtn,fontSize: FontSizes.FONT_16),),
                        shape: Styles.btnShape,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height:8.0),
                container2('lib/assets/images/image1.jpg','Active Services','Care Taker 24 hour - Present','20 May 2020'),
                SizedBox(height:8.0),
                container2('lib/assets/images/payment.jpg','Daily Attendance','Care Taker 24 hour - Present','20 May 2020'),
              ],
            )),
          ],
        ),
      ),
    );
  }
  Widget container1(image,title){
    return Stack(
      children: <Widget>[
        Material(
          child: ClipRRect(
            child: Image.asset(image,fit: BoxFit.cover,),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            color: black50,
            child: Center(child: Text(title,style: Styles.whiteTextwithf20w6,)),
          ))
      ],
    );
  }
    Widget container2(image,title,subtitle,time){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, activeServicePage,arguments: {'title': title});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        decoration: BoxDecoration(
          color: white100,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width/3,
              height: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                child: Image.asset(image,fit: BoxFit.cover,))),
            SizedBox(width:16.0),
            Container(
              width: MediaQuery.of(context).size.width*2/3-50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,style: Styles.blackTextwithf16w6),
                  Text(subtitle,style: Styles.blackopacity5f14, ),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(time,style: Styles.blackopacity5f14,)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  profile(){
    return SingleChildScrollView(
      child: Container(
        //height: double.infinity,
        color: greyBackgroundColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('$name',style: Styles.secondaryTextwithf28,),
                    SizedBox(height: 12.0,),
                    Text('$email',style:Styles.secondaryTextwithf14)
                  ],
                ),
                Button(
                  title: 'Edit',
                  onpress: (){ 
                    setState(() {
                    //indexno = 8 ;
                    //_isleading = true ;
                    _isprofileEdit= true ;
                    //title='Edit Profile';
                  });
                   } ,
                  color: secondaryColor,
                  height: 34.0,
                  //width: MediaQuery.of(context).size.width/2,
                  textStyle: Styles.whiteTextwithf16,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                )
              ],
            ),
            SizedBox(height: 64.0,),
//             Container(
//               padding: EdgeInsets.fromLTRB(16.0,8.0,16.0,8.0),
//               decoration: BoxDecoration(
//                 color: white100,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: InkWell(
//                 onTap: (){
//                   setState(() {
// //                    indexno = 9 ;
// //                    _isleading = true ;
// //                    title='My saved resources';
//                   });
//                   Navigator.pushNamed(context, screen,arguments: {'screenid':1});
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Icon(Icons.folder,color:secondaryColor,size: 30.0,),
//                     Container(color: secondaryColor ,child: SizedBox(width: 1.0,height: 50.0,)),
//                     SizedBox(width:8.0 ,),
//                     Text('Saved Resources',style: Styles.secondaryTextwithf18,),
//                     SizedBox(width:8.0 ,),
//                     Stack(
//                       overflow: Overflow.visible,
//                       children: <Widget>[
//                         CircleContainer(
//                           size: 28.0,
//                           backcolor: secondaryColor,
//                           title: '2',
//                         ),
//                         Positioned(
//                           right: 0.0,
//                           child: CircleContainer(
//                           size: 8.0,
//                           backcolor: warningColor,
//                           title: '',
//                         ),)
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
            SizedBox(height:16.0),
            Container(
              height: 72.0 * profileList.length,
              padding: EdgeInsets.only(top:8.0,bottom: 8.0),
              decoration: BoxDecoration(
                color: white100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: profileList.length,
                itemBuilder: (context,int){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        indexno = int==0 ? 10 :int ;
                        _isleading = int==0 ? false :true ;
                        title= int==0 ? 'My Profile' :profileList[int];
                      });
                      int == profileList.length-1 ?
                      _logoutUser(0) :
                      int == 0 ?
                      Navigator.pushNamed(context, category) :
                      int == 1 ?
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => WebViewPage(
                          path: '$webUrlAbout',
                          title: '${profileList[int]}', ),
                      )) :
                      int == 2 ?
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => WebViewPage(
                          path: '$webUrlTerms',
                          title: '${profileList[int]}', ),
                      )):
                      (){} ;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: int == profileList.length-1 ? BorderSide(width: 0.0,color: white100) : BorderSide(color: secondaryColor)
                        )
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(32.0,6.0,32.0,6.0),
                        title: Text('${profileList[int]}',style: Styles.secondaryTextwithf18,),
                        trailing: Icon(Icons.arrow_forward_ios,size: 24.0,color: secondaryColor,),
                      ),
                    ),
                  );
                }),
            )
          ],
        ),
      ),
    );
  }
  void _logoutUser(id) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnloggedin : id,
    };
    final rowsAffected = await dbHelper.update(row);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear() ;
    Navigator.pushNamed(context, splash);
    //print('updated $rowsAffected row(s)');
  }
}