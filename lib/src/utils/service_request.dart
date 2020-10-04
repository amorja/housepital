import 'dart:convert';
import 'dart:io';
import 'package:housepital/src/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:housepital/src/constants/constants.dart';


class ServiceRequest {
  // this the service request params used to call for
  // to get user data from backend or used for
  // server communications
  static String url= AppFlavorConfig.instance.flavorValues.baseUrl ;
  static Future<void> call(
    {
    url,
    @required method,
    @required Function successCallback,
    @required Function failureCallback,
    headers,
    requestBody,
  }) async {
    try {
      http.Response response;
      if (method == HttpMethods.GET) {
        response = await http.get(url, headers: headers,);
      } else if (method == HttpMethods.POST) {
        response = await http.post(url, headers: headers, body: requestBody);
      }
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        failureCallback({
          'error': "Error while fetching data: $statusCode"
        });
      }
      final responseJson = jsonDecode(response.body);
      if (successCallback is Function) {
        successCallback(responseJson);
      } else {
        failureCallback({
          'error': 'Please defined successCallback function'
        });
      }
    } catch (error) {
      if (failureCallback is Function) {
        failureCallback(error);
      }
    }
  }

  static Future<void> uploadFile(
    url,
    filePath,
    successCallback,
    failureCallback
  ) async {
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    
    request.fields['userId'] = 'UserId';
    request.files.add(await http.MultipartFile.fromPath(
      'package',
      filePath,
    ));
    var response = await request.send();
    if (response.statusCode == 200){
      successCallback(response);
    } else {
      failureCallback(response);
    }
  }

  
}