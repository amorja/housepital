import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/font_sizes.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/utils/database_helper.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/utils/validation.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:housepital/src/widget/logoContainer.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dbHelper = DatabaseHelper.instance;
  final _mainformKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController forgotController = TextEditingController();
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String tokenid ;

  actionButton() async {
    final prefs = await SharedPreferences.getInstance();
    //print('login Data: ${prefs.getString('data_global')}');
    
    await ServiceRequest.call(
      url: '${finalUrl}login',
      method: HttpMethods.POST,
      requestBody: {'mobile': mobileController.text},
      successCallback: success,
      failureCallback: failure
    );

  }

  void success(res) async{
    if(res['code']=="101"){
       //print('${res['result']['next_page']['page_code']}');
       final prefs = await SharedPreferences.getInstance();
       prefs.setString('mobile', '${res['result']['mobile']}');
       prefs.setString('message', '${res['message']}');
       _update(1,'${res['result']['mobile']}');
      // String redirecturl= res['result']['next_page']['page_code'] ;
      Navigator.pushNamed(context, otpscreen);
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
                height: 300.0,
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
                      child: Form(
                        key: _mainformKey,
                        child: TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.emailAddress,
                          //textAlign: TextAlign.center,
                          style: Styles.blackopacity5f18,
                          decoration: InputDecoration(
                            hintText: 'Enter your Mobile Number',
                            hintStyle : Styles.blackopacity5f18,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          validator: (value)=> isValidMobile(value)? null : 'Enter a valid Mobile Number',
                        ),
                      ),
                    ),
                    Button(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      title: 'Login',
                      color: primaryBtnColor,
                      onpress: (){
                        final form = _mainformKey.currentState;
                          if (form.validate()) {
                            actionButton();
                          }
                      },
                      textStyle: Styles.whiteTextwithf20w6,
                      shape: Styles.btnShapefillcolor, )
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
  void _update(loggedin,mobile) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnusername  : mobile
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
}