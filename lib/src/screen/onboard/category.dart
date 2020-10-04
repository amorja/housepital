import 'dart:convert';

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

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String title='Welcome to the BMC';
  String subtitle='Select as many category as you like...';
  String selectedChoice = "";
  String data_global='';
  int _isfeeling = 0 ;
  List<String> selectedChoices = List();
  TextStyle selectedColor = Styles.whiteTextwithf18;
  TextStyle basicChipColor = Styles.blackTextwithf18;
  List reportList=[];
  
  actionButton() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      data_global = prefs.getString('data_global');
      //data_global='R2l3Zi9JWUdqekhSa05Ed0NPQjgrNjBNYmVnMzRnMlgxS3I3TW9LQnZWM3FUTThJNzFGTktNME0xWWRTUllQK0tueDZOUDh3ZC8yRTFiL2dmTDFwaU1GMEFUWXB1WlVoZkwxWk8wcjBKOEJ6azRUWVZ5ZkoxdkhRckxmRUZ5dUdKYk1qZGIwSjlVTmlKVEc4REc5aHU5WWdBcmlDbTN6bDhEdWdEK3VNSXhpWWlQMnlyeXlva09jTTI3K2NTWmp0UE1LSWV2dmFCRUNiRkpKWnJaQkYrRGJ3RjFCbFhtTG1UVXEyQ2xsNEVVaz0=';
   
    });
     await ServiceRequest.call(
      url: '${finalUrl}get_category',
      //url: 'http://incontactadmin.co.uk/mobile/registration',
      method: HttpMethods.POST,
      requestBody: {'data_global': data_global},
      successCallback: success,
      failureCallback: failure
    );

  }

  void success(res) async{
    if(res['code']=='101'){
      var _duration = new Duration(seconds: 2);
      //showToast('${res['message']}',context) ;
      setState(() {
        res['result'].forEach((index) {
        if(index['is_selected']==1){
          selectedChoices.add("${index['data_self']}");
        }
      });
      reportList = res['result'];
      });
      
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
  // List<String> reportList = [
  //   "Sadness",
  //   "Contempt",
  //   "Excitement",
  //   "Guilt",
  //   "Joy",
  //   "Anger",
  //   "Surprise",
  //   "Fear",
  //   "Shame",
  //   "Disgust"
  // ];
  @override
  void initState() {
    super.initState();
    actionButton();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
          child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top:30.0),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(title,style: Styles.blackTextwithf20w6,),
                      SizedBox(height: 32.0,),
                      Text(subtitle,style: Styles.blackTextwithf14,),
                      SizedBox(height: 32.0,),
                      Wrap(
                        children: _buildChoiceList(),
                      ),
                      SizedBox(height: 32.0,),
                    ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 20.0),
                    color: white100,
                    height: 60.0,
                    width: MediaQuery.of(context).size.width,
                    child: Button(
                      title: 'I agree',
                      onpress: (){ gotosubmit(context); } ,
                      color: secondaryColor,
                      width: MediaQuery.of(context).size.width,
                      textStyle: Styles.whiteTextwithf16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
  _buildChoiceList() {
    List<Widget> choices = List();
    reportList.forEach((item) {
      print(reportList.length);
      choices.add(Container(
        padding: const EdgeInsets.all(6.0),
        child: ChoiceChip(
          label: Text('${item['name']}',),
          selected: selectedChoices.contains("${item['data_self']}"),
          labelStyle: selectedChoices.contains("${item['data_self']}") ? selectedColor :
          basicChipColor  ,
          //backgroundColor: item['is_selected']==1 ? primaryColor : grey77,
          selectedColor: primaryColor,
          disabledColor: grey77,
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains("${item['data_self']}")
                ? selectedChoices.remove("${item['data_self']}")
                : selectedChoices.add("${item['data_self']}");
            });
          },
        ),
      ));
    });
    return choices;
  }
  gotosubmit(context) async{
    
    var category= jsonEncode(selectedChoices)  ;
    print(category);
    await ServiceRequest.call(
      url: '${finalUrl}save_category',
      //url: 'http://incontactadmin.co.uk/mobile/registration',
      method: HttpMethods.POST,
      requestBody: {'data_global': data_global,'data_self_array' : category },
      successCallback: successsave,
      failureCallback: failuresave
    );
    
  }
  void successsave(res) async{
    if(res['code']=='101'){
      var _duration = new Duration(seconds: 2);
      showToast('${res['message']}',context) ;
      Navigator.pushNamed(context, screen,arguments: {'screenid':0});
      
    }
    else {
      showToast('${res['message']}',context) ;
    }
  }

  failuresave(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }
}