import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/screen/profile/profileedit.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  //ProfileEdit parent ;
  ChangePassword({ Key key }) : super(key: key);
    @override
    _ChangePasswordState createState() => _ChangePasswordState();
  }


class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController= TextEditingController();
  TextEditingController repasswordController= TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String data_global ;

  saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await ServiceRequest.call(
      url: '${finalUrl}save_profile_data',
      method: HttpMethods.POST,
      requestBody: {'data_global' : data_global,
          'password': passwordController.text,
      },
      successCallback: successsave,
      failureCallback: failuresave
    );

  }
  void successsave(res) async{
    if(res['code']=='101'){
      showToast('${res['message']}',context) ;
      setState(() {
        repasswordController.text='';
        passwordController.text= '';
      });
      // print('Key1: ${key.currentState.ispassword}');
      // key.currentState.setState(() {
      //   key.currentState.ispassword =false ;
      // }) ;
      // print('Key2: ${key.currentState.ispassword}');
      // key.currentState.build(context);
      Navigator.of(context).pop();
    }
    else{
      showToast('${res['message']}',context) ;
    }
  }
  failuresave(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }
  read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      data_global=prefs.getString('data_global');
    });

  }
  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          ),
          elevation: 8.0,
          child: Padding(padding: const EdgeInsets.fromLTRB(16.0,24.0,16.0,24.0),
           child: Form(
             key: _formKey,
             child: Column(
               children: <Widget>[
                 TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  style: Styles.blackTextwithf16,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Styles.blackTextwithf16,
                    enabledBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: black100)
                    )
                  ),
                ),
                SizedBox(height: 12.0,),
                TextFormField(
                  controller: repasswordController,
                  keyboardType: TextInputType.text,
                  style: Styles.blackTextwithf16,
                  decoration: InputDecoration(
                      labelText: 'Retype Password',
                      labelStyle: Styles.blackTextwithf16,
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: black100)
                      )
                  ),
                  validator: (val){
                    if(val != passwordController.text)
                      return 'Not Match' ;
                    return null;
                  }
                ),
                SizedBox(height: 30.0,),
                Button(
                  title: 'Save',
                  onpress: (){
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      saveData();
                    }
                  },
                  color: secondaryColor,
                  width: MediaQuery.of(context).size.width,
                  textStyle: Styles.whiteTextwithf18,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                SizedBox(height: 20.0,),
               ],
             )
           ),
          ),
        ),
    );
  }
}