import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpSupport extends StatefulWidget {
  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool _isthankyou =false ;
  actionButton() async {
    final prefs = await SharedPreferences.getInstance();
    await ServiceRequest.call(
        url: '${finalUrl}help',
        method: HttpMethods.POST,
        requestBody: {'data_global' : prefs.getString('data_global') , 'subject': subjectController.text,'message': messageController.text},
        successCallback: success,
        failureCallback: failure
    );

  }

  void success(res) async{
    if(res['code']=="101"){

      showToast('${res['message']}',context) ;
      subjectController.text='';
      messageController.text='';
      setState(() {
        _isthankyou = true ;
      });
     // Navigator.pushNamed(context, screen,arguments: {'screenid':4});
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
  thankyouScreen(){
    return Container(
      margin: EdgeInsets.only(top:10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: white100,
        borderRadius: BorderRadius.circular(8.0)
      ),
      height: MediaQuery.of(context).size.height-170,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //SizedBox(height:20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('lib/assets/logo/ShawBot.png'),
                SizedBox(width:10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('',style: Styles.secondaryTextwithf20,),
                    Text('ShawBot',style: Styles.secondaryTextwithf16,)
                  ],
                ),
              ],
            ),
            SizedBox(height:10.0),
            Column(
              children: <Widget>[
                Text('Thanks',style: Styles.blackTextwithf30w6,),
                SizedBox(height:30.0),
                Text('We will get back to you soon!',style: Styles.blackTextwithf18,),
              ],
            ),
            SizedBox(height:20.0),
            Text('Message Sent!',style: Styles.blackopacity5f18,),
            //SizedBox(height:10.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return helpwidget() ;
  }
  helpwidget(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32.0),
        width: MediaQuery.of(context).size.width,
        color: greyBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _isthankyou ? thankyouScreen ()  : Container(
              margin: EdgeInsets.only(top:20.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: white100,
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height:10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset('lib/assets/logo/ShawBot.png'),
                      SizedBox(width:10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('To the inContact team',style: Styles.secondaryTextwithf20,),
                          SizedBox(height:8.0),
                          Text('ShawBot',style: Styles.secondaryTextwithf16,)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height:20.0),
                  Text('Subject',style: Styles.secondaryTextwithf20,),
                  SizedBox(height:10.0),
                  TextFormField(
                    controller: subjectController,
                    minLines: 2,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    style: Styles.blackTextwithf16,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height:40.0),
                  TextFormField(
                    controller: messageController,
                    minLines: 8,
                    maxLines: 8,
                    keyboardType: TextInputType.text,
                    style: Styles.blackTextwithf16,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height:20.0),
                  Button(
                    title: 'Next',
                    onpress: (){
                      actionButton();
                    },
                    color: primaryColor,
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    textStyle: Styles.whiteTextwithf18,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)
                    ),
                  ),
                  SizedBox(height:20.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}