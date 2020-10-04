
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

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController mobileController = TextEditingController();
  TextEditingController forgotController = TextEditingController();
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String tokenid ;
  String message ;

  resendButton() async {
    final prefs = await SharedPreferences.getInstance();
    await ServiceRequest.call(
        url: '${finalUrl}login',
        method: HttpMethods.POST,
        requestBody: {'mobile': prefs.getString('mobile')},
        successCallback: resendSuccess,
        failureCallback: resendFailure
    );

  }
  void resendSuccess(res){
    if(res['code']=="101"){
      showToast('${res['message']}',context) ;
    }
    else{
      showToast('${res['message']}',context) ;
    }
  }
  resendFailure(e) {
    /// handle any error if user stuck in this
    /// user doesn't get effected by this call;
    print('Error on force update: $e');
  }


  actionButton() async {
    final prefs = await SharedPreferences.getInstance();
    //print('login Data: ${prefs.getString('data_global')}');
    
    await ServiceRequest.call(
      url: '${finalUrl}confirm_otp',
      method: HttpMethods.POST,
      requestBody: {'mobile': prefs.getString('mobile'),'otp': mobileController.text},
      successCallback: success,
      failureCallback: failure
    );
  }

  void success(res) async{
    if(res['code']=="101"){
       //print('${res['result']['data_global']}');
       final prefs = await SharedPreferences.getInstance();
       prefs.setString('name', '${res['result'][0]['name']}');
       prefs.setString('data_global', '${res['result'][0]['data_global']}');
       _update(1 ,
        '${res['result'][0]['name']}','${res['result'][0]['data_global']}');
      // String redirecturl= res['result']['next_page']['page_code'] ;
      Navigator.pushNamed(context, screen,arguments: {'screenid':0});
      //Navigator.pushNamed(context, res['result']['next_page']['page_code'],arguments: {'screenid':0});
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
  
  void read() async{
    final prefs = await SharedPreferences.getInstance();
    message= prefs.getString('message');
    showToast(message,context) ;
  }
  
  @override
  void initState() {
    // _firebaseMessaging.getToken().then((token) {
    //   setState(() {
    //     tokenid = token ;
    //     print('Device: $tokenid');
    //   });
    // });
    read();
    //showToast('${res['message']}',context) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/logo/home_background.png"),
          fit: BoxFit.cover)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white100,
                ),
                height: 370.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image.asset('lib/assets/logo/logo.png'),
                    Container(
                      padding: EdgeInsets.only(left:16.0,right: 16.0,top: 8.0,bottom: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: grey77,width: 1.0),
                        borderRadius: BorderRadius.circular(10),
                        color: white100,
                      ),
                      child: TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.emailAddress,
                        //textAlign: TextAlign.center,
                        style: Styles.blackopacity5f18,
                        decoration: InputDecoration(
                          hintText: '4 Digit OTP',
                          hintStyle : Styles.blackopacity5f18,
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Button(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      title: 'Verify',
                      color: primaryBtnColor,
                      onpress: (){
                        actionButton();
                      },
                      textStyle: Styles.whiteTextwithf20w6,
                      shape: Styles.btnShapefillcolor,),
                    Button(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      title: 'Resend OTP',
                      color: white100,
                      onpress: (){
                        resendButton();
                      },
                      textStyle: Styles.btnTextwithf18w6,
                      shape: Styles.btnShapeOrangeColor,)
                  ],
                ),
              ),
            )
          )
        )
      )
    );
  }

  _goToRegister(context){
    Navigator.pushNamedAndRemoveUntil(context, registration,(Route<dynamic> route) => false);
  }

  void showToast(String msg, context) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,backgroundColor:primaryColor);
  }
  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }
  void _update(loggedin,name,data) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnloggedin  : loggedin,
      DatabaseHelper.columnname  : name,
      DatabaseHelper.columndata  : data
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
}