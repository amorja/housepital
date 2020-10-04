import 'dart:convert';
import 'dart:io';

import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/constants.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/constants/urls.dart';
import 'package:housepital/src/routes/route_const.dart';
import 'package:housepital/src/utils/database_helper.dart';
import 'package:housepital/src/utils/service_request.dart';
import 'package:housepital/src/widget/button.dart';
import 'package:housepital/src/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  
  final dbHelper = DatabaseHelper.instance;
  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController companyController= TextEditingController();
  TextEditingController mobileController= TextEditingController();
  TextEditingController addressController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController repasswordController= TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _country = '';
  String imgURL='' ;
  String password ;
  String data_global ;
  String title= 'Edit Profile';
  final String url = countryjson;
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
  startTime(String data) async {
    await ServiceRequest.call(
      url: '${finalUrl}get_profile_data',
      method: HttpMethods.POST,
      requestBody: {'data_global' : data == null ? '' : data},
      successCallback: success,
      failureCallback: failure
    );

  }
  void success(res) {
    if(res['code']=='101'){
       print('${res['result']['next_page']['page_code']}');
      
      setState(() {
        nameController.text= '${res['result']['name']}';
        _country = '${res['result']['country']}';
        imgURL = '${res['result']['avatar']}';
        mobileController.text = '${res['result']['mobile']}';
        companyController.text = '${res['result']['company']}';
        addressController.text = '${res['result']['address']}';

      });
      
    }
    else if(res['code']=='10'){

    }
  }
  failure(e) {
      /// handle any error if user stuck in this
      /// user doesn't get effected by this call;
      print('Error on force update: $e');
    }
  read() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      data_global=prefs.getString('data_global');
    });
    startTime(data_global);

  }
  saveData(String data) async {
    await ServiceRequest.call(
      url: '${finalUrl}save_profile_data',
      method: HttpMethods.POST,
      requestBody: {'data_global' : data,
          'password': passwordController.text,
          'name' : nameController.text ,
          'avatar' : '',
          'mobile' : mobileController.text,
          'country': _country,
          'company' : companyController.text,
          'address' : addressController.text },
      successCallback: successsave,
      failureCallback: failuresave
    );

  }
  void successsave(res) async{
    if(res['code']=='101'){
      showToast('${res['message']}',context) ;
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
      setState(() {
        nameController.text= '${res['result']['name']}';
        mobileController.text = '${res['result']['mobile']}';
        companyController.text = '${res['result']['company']}';
        addressController.text = '${res['result']['address']}';
        _country = '${res['result']['country']}';
        repasswordController.text='';
        passwordController.text= '';
        data_global='${res['result']['data_global']}' ;
        startTime(data_global);
      });
      
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

  static final String uploadEndPoint =
      '${finalUrl}profile_image_upload';
  File file;
  String status = '';
  String base64Image;
  File _pickedImage;
  bool _isUploading= false;
  String errMessage = 'Error Uploading Image';
  bool ispassword=false;
    void _pickImage() async {

    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8.0,
              title: Text("Select the image source",style: Styles.whiteTextwithf16,),
              actions: <Widget>[
                MaterialButton(
                  elevation: 8.0,
                  color: white100,
                  shape: CircleBorder(),
                  child: Icon(Icons.camera_alt,color:primaryColor),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  elevation: 8.0,
                  color: white100,
                  shape: CircleBorder(),
                  child: Icon(Icons.insert_photo,color:primaryColor),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            )
    );

    if(imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if(file != null) {
        setState(() => _pickedImage = file );
        //upload(_pickedImage);
        _startUploading();
      }
    }
  }
 
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });
    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(uploadEndPoint));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    print('Type: ${mimeTypeData[1]}');
    imageUploadRequest.fields['data_global'] = data_global;
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print('status : ${response.statusCode}');
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }
  void _resetState() {
    setState(() {
      _isUploading = false;
      _pickedImage = null;
    });
  }
  void _startUploading() async {
    final Map<String, dynamic> response = await _uploadImage(_pickedImage);
    print(response['result']['avatar']);
    setState(() {
      imgURL = response['result']['avatar'];
    });
    // Check if any error occured
    if (response == null || response.containsKey("error")) {
      Toast.show("Image Upload Failed!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Image Uploaded Successfully!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    super.initState();
    //read();
    //loadPerson(countryjson);
  }
  @override
  Widget build(BuildContext context) {
    print('Image : ${imgURL == 'null'  ?'http://incontactadmin.co.uk/data/app/1590553204.jpg' : imgURL }' );
    return Scaffold(
      backgroundColor: greyBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back_ios,color: black100,) ,
                    onPressed: (){
                      ispassword ?
                      setState(() {
                          ispassword = false ;
                        })
                      : Navigator.pushNamed(context, screen,arguments: {'screenid':2});
                    }),
                    Text('$title',style: Styles.blackTextwithf20w6,),
                    IconButton(icon: Icon(Icons.edit,color: black100,) ,
                    onPressed: (){
                      _pickImage();
                    }),
                    //SizedBox(width:20.0),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130.0,
                  child: 
                  Image.network(imgURL == 'null'  ?'http://incontactadmin.co.uk/data/app/1590553204.jpg' : imgURL ,fit: BoxFit.contain,)),
              ],
            ),
            SizedBox(height:16.0),
            Expanded(
              child: SingleChildScrollView(
                child: buildProfileEdit(),
              ),
            )
          ],
        ),
      ),
    );
  }
 buildProfileEdit(){
    return ispassword ? ChangePassword(this) : Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        ),
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0,24.0,16.0,24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                style: Styles.blackTextwithf16,
                decoration: InputDecoration(
                  labelText: 'FullName',
                  labelStyle: Styles.blackTextwithf16,
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: black100)
                  )
                ),
              ),
              SizedBox(height: 12.0,),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                style: Styles.blackTextwithf16,
                decoration: InputDecoration(
                    labelText: 'Mobile No.',
                    labelStyle: Styles.blackTextwithf16,
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: black100)
                    )
                ),
              ),
              SizedBox(height: 8.0,),
              FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Country',
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
              TextField(
                controller: companyController,
                keyboardType: TextInputType.text,
                style: Styles.blackTextwithf16,
                decoration: InputDecoration(
                    labelText: 'Company',
                    labelStyle: Styles.blackTextwithf16,
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: black100)
                    )
                ),
              ),
              TextField(
                controller: addressController,
                keyboardType: TextInputType.text,
                style: Styles.blackTextwithf16,
                decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: Styles.blackTextwithf16,
                    enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: black100)
                    )
                ),
              ),
              SizedBox(height: 30.0,),
              Button(
                title: 'Change Password',
                onpress: (){
                  setState(() {
                    ispassword = true ;
                    title='Change Password' ;
                  });
                },
                color: secondaryColor,
                width: MediaQuery.of(context).size.width,
                textStyle: Styles.whiteTextwithf18,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
              ),
              SizedBox(height: 30.0,),
              Button(
                title: 'Save',
                onpress: (){
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    saveData(data_global);
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
            )),
        ),
      ),
    );
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
  }
}

class ChangePassword extends StatefulWidget {
  _ProfileEditState parent ;
  ChangePassword(this.parent);
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
      print('Key1: ${this.widget.parent.ispassword}');
      this.widget.parent.setState(() {
        this.widget.parent.ispassword =false ;
      }) ;
      print('Key2: ${this.widget.parent.ispassword}');
      // key.currentState.build(context);
      //Navigator.of(context).pop();
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