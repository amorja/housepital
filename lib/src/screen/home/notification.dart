import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/utils/string_utils.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/logoContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  bool _isloading = true  ;
  List notificationList = List();

  startTime(String data) async {
    print('Data : $data /n');
    //return new Timer(_duration, navigationPage);
    await ServiceRequest.call(
      url: '${finalUrl}notification',
      method: HttpMethods.POST,
      requestBody: {'data_global' : data},
      successCallback: success,
      failureCallback: failure
    );

  }
  void success(res) {

    if(res['code']== "101"){
      print('hi');
      print('${res['result'].length }');
      setState(() {
        notificationList= res['result'] ;
        _isloading = false ;
      });
    }
    else if(res['code']=='10'){

    }
    else{
      print('${res['message']}');
    }
  }
  failure(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }
  read() async{
    final prefs = await SharedPreferences.getInstance();
    startTime(prefs.getString('data_global'));
  }

  @override
  void initState() {
    // TODO: implement initState
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: CustomAppbar(
          title : 'Notification',
          leadingbtn: true,
          actionbtn: false, ),
        ),
        backgroundColor: greyBackgroundColor,
        body: Container(
          margin: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          padding: EdgeInsets.fromLTRB(0.0, 8.0,0.0, 8.0),
          height: 72.0 * notificationList.length,
          decoration: BoxDecoration(
            color: white100,
            borderRadius: BorderRadius.circular(12.0)
          ),
          child: _isloading ? Center(
            child: CircularProgressIndicator(),
          )
            : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: notificationList.length,
                  itemBuilder: (BuildContext context, int){
                    var timetext= readTimestamp(notificationList[int]['time']);
//                    var date = DateTime.fromMillisecondsSinceEpoch(notificationList[int]['time']);
//                    var formattedDate = DateFormat.().format(date);
                    return Container(
                      decoration: BoxDecoration(
                          color:white100,
                        border: Border(
                          bottom: int==notificationList.length-1 ? BorderSide.none : BorderSide(width: 1.0,color: black100)
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: HexColor(
                                  notificationList[int]['dot_color']
                                )
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 130 ,
                              child: Text('${notificationList[int]['text']}',style: Styles.blackTextwithf12,)),
                            Text('$timetext',style: Styles.blackTextwithf12,)

                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
        ),

    );
  }
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0) {
      time = 'now';
    }
    else if (diff.inHours > 0 && diff.inDays == 0){
      time =  diff.inHours.toString() + ' h ago';
    }
    else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' d ago';
      } else {
        time = diff.inDays.toString() + ' d ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' w ago';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' w ago';
      }
    }

    return time;
  }
}