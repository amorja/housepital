import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/services.dart';

Future<String> loadPersonFromAssets(jsonurl) async {
        return await rootBundle.loadString(jsonurl);
  }
  Future loadPerson(jsonurl) async {
    String jsonString = await loadPersonFromAssets(jsonurl);
    final jsonResponse = json.decode(jsonString);
    return jsonResponse ;
  }
  // Future<List> loadPerson(jsonurl) async {
  //   var url = jsonurl;
  //   HttpClient client = new HttpClient();
  //   HttpClientRequest request = await client.getUrl(Uri.parse(url));
  //   HttpClientResponse response = await request.close();
  //   return response.transform(UTF8.decoder).transform(JSON.decoder).toList();
  // }