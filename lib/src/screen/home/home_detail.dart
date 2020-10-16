import 'package:auto_size_text/auto_size_text.dart';
import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/screen/home/webViewPage.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/appbar.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:flutter/material.dart';
//package:flutter/src/widgets/basic.dart
import 'package:shared_preferences/shared_preferences.dart';

class DetailedPage extends StatefulWidget {
  Map argu;
  DetailedPage(this.argu);
  @override
  _DetailedPageState createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  List<dynamic> homeData;
  bool progress = false;
  String data_global;

  actionButton() async {
    final prefs = await SharedPreferences.getInstance();

    //print('darar${widget.argu['data_self']}' );
    setState(() {
      data_global = prefs.getString('data_global');
      //data_global='R2l3Zi9JWUdqekhSa05Ed0NPQjgrNjBNYmVnMzRnMlgxS3I3TW9LQnZWM3FUTThJNzFGTktNME0xWWRTUllQK0tueDZOUDh3ZC8yRTFiL2dmTDFwaU1GMEFUWXB1WlVoZkwxWk8wcjBKOEJ6azRUWVZ5ZkoxdkhRckxmRUZ5dUdKYk1qZGIwSjlVTmlKVEc4REc5aHU5WWdBcmlDbTN6bDhEdWdEK3VNSXhpWWlQMnlyeXlva09jTTI3K2NTWmp0UE1LSWV2dmFCRUNiRkpKWnJaQkYrRGJ3RjFCbFhtTG1UVXEyQ2xsNEVVaz0=';
    });
    await ServiceRequest.call(
        url: '${widget.argu['data_url']}',
        //url: 'http://incontactadmin.co.uk/mobile/registration',
        method: HttpMethods.POST,
        requestBody: {
          'data_global': data_global,
          'data_self': '${widget.argu['data_self']}'
        },
        successCallback: success,
        failureCallback: failure);
  }

  void success(res) async {
    if (res['code'] == '101') {
      var _duration = new Duration(seconds: 2);
      //showToast('${res['message']}',context) ;
      setState(() {
        homeData = res['result'];
        progress = false;
      });
    } else {
      showToast('${res['message']}', context);
    }
  }

  failure(e) {
    /// handle any error if user stuck in this
    /// user doesn't get effected by this call;
    print('Error on force update: $e');
  }

  @override
  void initState() {
    super.initState();
    actionButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: CustomAppbar(
          title: '${widget.argu['data_heading']}',
          leadingbtn: true,
        ),
      ),
      body: progress
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : projectwidget(),
    );
  }

  Widget layoutDetail() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          search(),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                container1(),
                SizedBox(height: 24.0),
                Text(
                  '3 Result Found',
                  style: Styles.primaryTextwithf18,
                ),
                Divider(
                  color: black75,
                ),
                SizedBox(height: 12.0),
                container2('lib/assets/images/image1.jpg', 'Nursing 24 hours',
                    'Per day - 3000 Rs',),
                SizedBox(height: 8.0),
                container2('lib/assets/images/image2.jpg', 'Nursing 12 hours',
                    'Per day - 1500 Rs',),
                SizedBox(height: 8.0),
                container2('lib/assets/images/image3.jpg', 'Nursing 6 hours',
                    'Per day - 1000 Rs',),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: grey77),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              //padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  print(text);
                },
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 36,
                  ),
                  hintText: 'Search ..',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: black25)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget container1() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.argu['data_heading']}',
            style: Styles.blackTextwithf24w6,
          ),
          SizedBox(height: 12.0),
          Text(
            'We have highly-qualified and experienced nurses who are trained to deliver top-notch nursing services which include post-surgical care, elderly care, chronic care, tracheostomy care, urinary catheterization care, wound care, injections, IV infusions, vaccination or other nursing assistance.',
            style: Styles.blackopacity5f18wlineheight,
          )
        ],
      ),
    );
  }

  Widget container2(image, title, subtitle) {
    
      // onTap: () {
      //   Navigator.pushNamed(context, pageExtanded, arguments: {
      //     'title': title,
      //     'image': image,
          

      //   });
      // },
      return Container(
      child: Material(
        elevation: 8.0,
        shadowColor: black100,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(image),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: Styles.blackTextwithf16w6,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    subtitle,
                    style: Styles.blackopacity5f14,
                  )
                ],
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ),
      ),
     );
  }


//  Widget container2(image,title,subtitle,time){
//     return Container(
//       padding: EdgeInsets.fromLTRB(16.0,8.0,8.0,8.0),
//       width: MediaQuery.of(context).size.width,
//       color: white100,
//       child: Row(
//         children: <Widget>[
//           Container(
//             width: 50.0,
//             child: Image.network(image)),
//           SizedBox(width:16.0),
//           Container(
//             width: MediaQuery.of(context).size.width-100,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(title,style: Styles.blackTextwithf16w6),
//                 Text(subtitle,style: Styles.blackopacity5f14, ),
//                 SizedBox(height: 8.0,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Text(time,style: Styles.blackopacity5f14,)
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }


  Widget projectwidget() {
    return new ListView.builder(
      itemCount: homeData == null ? 0 : homeData.length,
      itemBuilder: (BuildContext context, i) {
        return _firstlayout(homeData[i]);
      },
    );
  }

  _firstlayout(data) {




    if (data['layout_code'] == "1") {
      // print('helo') ;

      return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Text(
          data['title'],
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange),
        ),
      );
    }
//my

    else if (data['layout_code'] == "30") {
      // print('helo') ;

      return Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Text(
            data['title'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ));
    } else if (data['layout_code'] == "31") {
      return Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            data['sub_text'],
            style: TextStyle(fontSize: 16),
          ));
    }
    
    
    
     else if (data['layout_code'] == "44") {

     
        return Container(
        // padding: EdgeInsets.all(3.0),
          
          //SizedBox(height: 0.0,),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, data['next_page']['page_code']
            ,arguments: {'data_heading': data['next_page']['data_heading']
            ,'data_self': data['next_page']['data_self'],'data_url': data['next_page']['data_url']});
         
          },

             child: container2(data['image'], data['title'], data['sub_text'])
            
            
            ),
     
        );
      
    } 
    
//mye



    else if (data['layout_code'] == "2") {
      if (data['image'] == "") {
        return new Container(
          child: new SizedBox(
            height: 15.0,
          ),
        );
      } else {
        return InkWell(
          onTap: () {
            if (data['web_view'] == "0") {
              Navigator.pushNamed(context, data['next_page']['page_code'],
                  arguments: data['next_page']);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(
                      path: data['web_link'],
                      title: data['web_view_heading'],
                    ),
                  ));
            }
          },
          child: Container(
            padding: EdgeInsets.all(6.0),
            margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.grey[400]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: new ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: new Image(
                      image: NetworkImage(data['image']),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: LinearProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 30.0,
                      child: AutoSizeText(
                        data['text'] != null ? data['text'] : "",
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        maxLines: 2,
                        minFontSize: 12.0,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      )),
                )
              ],
            ),
          ),
        );
      }
    } else if (data['layout_code'] == "3") {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewPage(
                  path: data['web_link'],
                  title: data['web_view_heading'],
                ),
              ));
        },
        child: Container(
            padding: EdgeInsets.all(6.0),
            margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            height: 90.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.grey[400]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Row(
              children: <Widget>[
                new Container(
                  height: 90.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data['image']))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data['text'] != null ? data['text'] : "",
                      style: TextStyle(color: Colors.black54, fontSize: 16.0),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                )
              ],
            )),
      );
    } else if (data['layout_code'] == "4") {
      return Container(
          margin: EdgeInsets.all(12.0),
          height: 400.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: new Column(
            children: <Widget>[
              new Expanded(
                child: new ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: new Image(
                    width: MediaQuery.of(context).size.width,
                    image: NetworkImage(data['image']),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Text(
                      data['text'] != null ? data['text'] : "",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Icon(
                      Icons.arrow_forward,
                      color: Colors.black54,
                      size: 30.0,
                    ),
                  )
                ],
              )
            ],
          ));
    } else if (data['layout_code'] == "5") {
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.all(8.0),
        height: 110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
              image: NetworkImage(data['image']), fit: BoxFit.cover),
        ),
      );
    } else if (data['layout_code'] == "6") {
      return Container(
          padding: EdgeInsets.all(6.0),
          margin: EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 2.0, bottom: 20.0),
                    child: new Text(
                      data['title'] != null ? data['title'] : "",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 2.0, bottom: 20.0),
                    child: new Text(
                      data['text'] != null ? data['text'] : "",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _listhrdata(data['elements'][0]),
                  _listhrdata(data['elements'][1]),
                  _listhrdata(data['elements'][2]),
                ],
              )
            ],
          ));
    } else {
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
        child: new Divider(
          height: 2.0,
          color: Colors.black,
        ),
      );
    }
    //return Text(data['layout_code'], style: TextStyle(color: Colors.deepPurple));




  }

  _listhrdata(datael) {
    String colorbg = datael['element_bg_color'].replaceAll('#', '0xff');
    String colorfont = datael['element_text_color'].replaceAll('#', '0xff');
    return new Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: new Color(int.parse(colorbg)),
      ),
      child: Center(
          child: new Text(
        datael['element_name'] != null ? datael['element_name'] : "",
        style:
            TextStyle(color: new Color(int.parse(colorfont)), fontSize: 18.0),
      )),
    );
    //return myList;
  }
}
