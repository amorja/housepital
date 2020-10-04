import 'dart:convert';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/font_sizes.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController= TextEditingController();
  TextEditingController companyController= TextEditingController();
  TextEditingController mobileController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _country = 'india';
  final String url = countryjson;
  bool _termsChecked = false;
  bool _istermsChecked = false;
  num _stackToView = 1;
  InAppWebViewController webView;
  double progress = 0;
  int progressbar=0;
  List countrylist = List(); //edited line
  Future<String> loadPersonFromAssets(jsonurl) async {
        return await rootBundle.loadString(jsonurl);
  }
  Future loadPerson(jsonurl) async {
    String jsonString = await loadPersonFromAssets(jsonurl);
    final jsonResponse = json.decode(jsonString);
    setState(() {
      countrylist=jsonResponse ;
    });
    //print('${countrylist[0][0]}');
    return jsonResponse ;
  }

  @override
  void initState() {
    super.initState();
    loadPerson(countryjson);
  }
  actionButton() async {
    //,'company': companyController.text,'mobile': mobileController.text,'country': _country,
    await ServiceRequest.call(
      url: '${finalUrl}registration',
      //url: 'http://incontactadmin.co.uk/mobile/registration',
      method: HttpMethods.POST,
      requestBody: {'email': emailController.text,'name' :  nameController.text,'password': passwordController.text,'mobile': mobileController.text,'country': _country},
      successCallback: success,
      failureCallback: failure
    );
  }

  void success(res) async{
    if(res['code']=='101'){
      var _duration = new Duration(seconds: 2);
      showToast('${res['message']}',context) ;
      Navigator.pushNamedAndRemoveUntil(context, switchAccount,(Route<dynamic> route) => false);
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
  showTerms(){
    return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0)), //this right here
        child: Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: IndexedStack(
              index: _stackToView,
              children: [
                Column(
                  children: < Widget > [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: InAppWebView(
                          initialUrl: "https://bmcadvisors.in/terms_conditions.php",
                          initialHeaders: {},
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                                debuggingEnabled: true,
                            )
                          ),
                          onWebViewCreated: (InAppWebViewController controller) {
                            webView = controller;
                          },
                          onLoadStart: (InAppWebViewController controller, String url) {
                            
                          },
                          onLoadStop: (InAppWebViewController controller, String url) async {
                            setState(() {
                              _stackToView=0;
                            });
                          },
                          onProgressChanged: (InAppWebViewController controller, int progress) {
                            setState(() {
                              progressbar=progress;
                              this.progress = progress / 100;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Loading : $progressbar %' ,style: Styles.blackTextwithf16w6,),
                        Container(
                        padding: EdgeInsets.all(10.0),
                        child: progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register',style: TextStyle(color:white100 ,fontFamily: 'Museo Sans', fontSize:FontSizes.FONT_18,fontWeight: FontWeight.w900)),
        backgroundColor: secondaryColor,
        elevation: 0,
      ),
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 32.0,right: 32.0,),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: white100
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                height: 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Register',style: TextStyle(color:black100 ,fontFamily: 'Museo Sans', fontSize:FontSizes.FONT_36,fontWeight: FontWeight.w900)),
                  
                  ],
                ),
              ),
              Form(key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      style: Styles.blackTextwithf16,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: Styles.blackTextwithf16,
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: secondaryColor)
                        )
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    // country feild
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: Styles.blackTextwithf16,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: Styles.blackTextwithf16,
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: secondaryColor)
                        )
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      style: Styles.blackTextwithf16,
                      decoration: InputDecoration(
                        labelText: 'Mobile(optional)',
                        labelStyle: Styles.blackTextwithf16,
                        hintText: 'Mobile (optional)',
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: secondaryColor)
                        )
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Country(optional)',
                            labelStyle: Styles.blackTextwithf16,
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(color: secondaryColor)
                            )
                          ),
                          isEmpty: _country == '',
                          child: countrylist.length==0 ?
                            Container()
                          : DropdownButtonHideUnderline(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: white100,
                              ),
                              child: DropdownButton(
                                itemHeight: 200.0,
                                style: Styles.blackTextwithf16,
                                value: _country.isNotEmpty ? _country : null,
                                isDense: true,
                                isExpanded: true,
                                iconEnabledColor: black100,
                                onChanged: (String newValue) {
                                  setState(() {
                                    //newContact.favoriteColor = newValue;
                                    _country = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: countrylist.length==0 ?
                                  new DropdownMenuItem(
                                    child: new Text('',style: Styles.blackTextwithf16,),
                                    value: '',
                                  )
                                : countrylist.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item[1],style: Styles.blackTextwithf16,),
                                    value: item[0].toString(),
                                  );
                                }).toList(),
                                
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8.0,),
                    // TextField(
                    //   controller: companyController,
                    //   keyboardType: TextInputType.text,
                    //   style: Styles.blackTextwithf16,
                    //   decoration: InputDecoration(
                    //     labelText: 'Company',
                    //     labelStyle: Styles.blackTextwithf16,
                    //     enabledBorder: new UnderlineInputBorder(
                    //       borderSide: new BorderSide(color: secondaryColor)
                    //     )
                    //   ),
                    // ),
                    // SizedBox(height: 8.0,),
                    TextField(
                      controller: passwordController,
                      style: Styles.blackTextwithf16,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: Styles.blackTextwithf16,
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: secondaryColor)
                        )
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    CheckboxListTile(
                      activeColor: Theme.of(context).accentColor,
                      title: Text('I agree to the Terms of Services and Privacy Policy',style: TextStyle( fontSize: 14),),
                      value: _termsChecked,
                      onChanged: (bool value) {
                        setState((){
                          _termsChecked = value ; 
                          _istermsChecked = true ;
                        } );
                      } ,
                      subtitle: !_istermsChecked
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0), 
                            child: Text('Required field', style: TextStyle(color: Color(0xFFe53935), fontSize: 12),),)
                        : null,
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            showTerms();
                          },
                          child: Text('Terms and Conditions',style: TextStyle(color: secondaryColor, fontSize: 16)),
                        )
                      ],
                    )
                  ]
              )),
            
              SizedBox(height: 30.0,),
              Button(
                title: 'Register',
                onpress: (){ 
                  _termsChecked ? actionButton() : setState(() => _istermsChecked = false);},
                color: secondaryColor,
                width: MediaQuery.of(context).size.width,
                textStyle: Styles.whiteTextwithf18,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
              ),
              SizedBox(height: 8.0,),
            ],
          ),
        ),
      ),
    );
  }
  _saveRegister(context){
    Navigator.pushNamedAndRemoveUntil(context, gdpr,(Route<dynamic> route) => false);
  }

  void showToast(String msg, context) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,backgroundColor:primaryColor);
  }
}