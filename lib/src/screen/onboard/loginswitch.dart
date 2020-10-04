import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/font_sizes.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/utils/database_helper.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:housepital/src/widget/logoContainer.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SwitchLoginPage extends StatefulWidget {
  @override
  _SwitchLoginPageState createState() => _SwitchLoginPageState();
}

class _SwitchLoginPageState extends State<SwitchLoginPage> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController userController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController forgotController = TextEditingController();
  //FirebaseMessaging _firebaseMessaging =FirebaseMessaging();
  String tokenid ;
  _showForgotDialog() async{
    await Future.delayed(Duration(milliseconds: 50));
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return Dialog(
            child: Container(
              height: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    width: MediaQuery.of(context).size.width,
                    color: primaryColor,
                    child: Center(child: Text('Forgot Password',style: Styles.whiteTextwithf18,))),
                  SizedBox(height:12.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: forgotController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: Styles.blackTextwithf18,
                      decoration: InputDecoration(
                          hintText: 'Enter Email',
                          alignLabelWithHint : false ,
                          hintStyle : Styles.blackTextwithf18,
                          enabledBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(color: black100)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height:12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Button(
                        title: 'SUBMIT',
                        onpress: (){
                          forgotButton();
                          Navigator.of(context).pop();
                        } ,
                        color: grey77,
                        width: MediaQuery.of(context).size.width/3,
                        textStyle: Styles.blackTextwithf16,

                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  forgotButton() async {
    await ServiceRequest.call(
        url: '${finalUrl}forgot_password',
        method: HttpMethods.POST,
        requestBody: {'email': forgotController.text},
        successCallback: forgotSuccess,
        failureCallback: forgotFailure
    );

  }
  void forgotSuccess(res){
    if(res['code']=="101"){
      showToast('${res['message']}',context) ;
    }
    else{
      showToast('${res['message']}',context) ;
    }

  }
  forgotFailure(e) {
    /// handle any error if user stuck in this
    /// user doesn't get effected by this call;
    print('Error on force update: $e');
  }

  actionButton() async {
   // _firebaseMessaging.getToken().then((token) {
  //     setState(() {
  //       tokenid = token ;
  //     });
  //  });
    await ServiceRequest.call(
      url: '${finalUrl}login',
      method: HttpMethods.POST,
      requestBody: {'email' : userController.text , 'password': passwordController.text },
      successCallback: success,
      failureCallback: failure
    );

  }

  void success(res) async{
    if(res['code']=="101"){
       print('${res['result']['next_page']['page_code']}');
       final prefs = await SharedPreferences.getInstance();
       prefs.setString('username', '${res['result']['username']}');
       prefs.setString('name', '${res['result']['name']}');
       prefs.setString('email', '${res['result']['email']}');
       prefs.setString('mobile', '${res['result']['mobile']}');
       prefs.setString('avatar', '${res['result']['avatar']}');
       prefs.setString('data_global', '${res['result']['data_global']}');
       _update(1,'${res['result']['username']}',
        '${res['result']['name']}','${res['result']['email']}',
        '${res['result']['mobile']}','${res['result']['data_global']}');
      //String redirecturl= res['result']['next_page']['page_code'] ;
      //Navigator.pushNamed(context, screen,arguments: {'screenid':0});
      Navigator.pushNamed(context, res['result']['next_page']['page_code']);
    }
    else {
      showToast('${res['message']}',context) ;
    }
  }

  failure(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }

  @override
  void initState() {
    // _firebaseMessaging.getToken().then((token) {
    //   setState(() {
    //     tokenid = token ;
    //     print('Device: $tokenid');
    //   });
    // });
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: 32.0,right: 32.0,),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: white100
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                height: MediaQuery.of(context).size.height/2.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    SizedBox(height: 10.0,),
                    SizedBox(height: 5.0,),
                    //LogoContainer(),
                    Container(
                      width: 240.0,
                      child: Column(
                        children: <Widget>[
                          Image.asset('lib/assets/logo/bmc_logo.jpg'),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: userController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    style: Styles.blackTextwithf16,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      alignLabelWithHint : false ,
                      hintStyle : Styles.blackTextwithf16,
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: secondaryColor)
                      )
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: Styles.blackTextwithf16,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      alignLabelWithHint : false ,
                      hintStyle : Styles.blackTextwithf16,
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: secondaryColor)
                      )
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 32.0,),
                  Button(
                    title: 'Sign in',
                    onpress: (){
                      actionButton();
                    },
                    color: secondaryColor,
                    width: MediaQuery.of(context).size.width,
                    textStyle: Styles.whiteTextwithf18,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Button(
                    title: 'Forgot password?',
                    onpress: (){
                      _goToForgetPassword(context);
                    },
                    textStyle: Styles.blackTextwithf16,
                  ),
                  //SizedBox(height: 8.0,),
                  // Button(
                  //   title: 'Switch account',
                  //   onpress: (){},
                  //   textStyle: Styles.primaryTextwithf16,
                  // ),
                  SizedBox(height: 16.0,),
                  InkWell(
                    onTap: (){
                      _goToRegister(context);
                    },
                    child: Text('First time user',style: TextStyle(color:black100 ,fontFamily: 'Museo Sans',fontSize:FontSizes.FONT_16,))),
                  SizedBox(height: 12.0,),
                  Button(
                    title: 'Register',
                    onpress: (){ _goToRegister(context); } ,
                    color: secondaryColor,
                    height: 36.0,
                    width: 120.0,
                    textStyle: Styles.whiteTextwithf16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  _goToRegister(context){
    Navigator.pushNamed(context, registration);
  }
  _goToForgetPassword(context){
    _showForgotDialog();
  }

  void showToast(String msg, context) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,backgroundColor:primaryColor);
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void _update(loggedin,username,name,email,avatar,data) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnloggedin  : loggedin,
      DatabaseHelper.columnusername  : username,
      DatabaseHelper.columnname  : name,
      DatabaseHelper.columnemail  : email,
      DatabaseHelper.columnavatar  : avatar,
      DatabaseHelper.columndata  : data
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) {
      print('data: ${row['data_global']}');
    });

  }

}