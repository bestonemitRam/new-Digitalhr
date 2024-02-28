import 'dart:convert';
import 'dart:io';
import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/data/source/network/model/login/Loginresponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bmiterp/utils/deviceuuid.dart';
import 'package:bmiterp/utils/constant.dart';

class Auth with ChangeNotifier {
  Future<Loginresponse> login(String username, String password) async {
    var uri = Uri.parse(APIURL.LOGIN_API);
    print("Login URL is - ");
    print(APIURL.LOGIN_API);

    Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};
    print("Header is :$headers");

    try {
      var fcm = await FirebaseMessaging.instance.getToken();
      print("FCM is :$fcm");

      Map<String, dynamic> Requestbody = {
        'employee_code': username,
        'password': password,
        'fcm_token': fcm,
        'device_type': Platform.isIOS ? 'ios' : 'android',
      };

      print("Login Request is :$Requestbody");
      final response =
          await http.post(uri, headers: headers, body: Requestbody);
      print("Login Response is  :$response");
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print("Response Status Code is - :${response.statusCode}");
        print(" inside the Response Status  :$responseData");

        print(responseData.toString());
        final responseJson = Loginresponse.fromJson(responseData);
        Preferences preferences = Preferences();

        await preferences.saveUser(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        print("Inside the Error Message part is :$errorMessage");
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  getMe() async {
    var uri = Uri.parse(APIURL.GET_ME);
    print("Login URL is - ");
    print(APIURL.GET_ME);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      // var fcm = await FirebaseMessaging.instance.getToken();
      // print("FCM is :$fcm");

      final response = await http.get(uri, headers: headers);
      print("Login Response is  :$response");
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print("Response Status Code is - :${response.statusCode}");
        print(" inside the Response Status  :$responseData");

        print(responseData.toString());
        final responseJson = Loginresponse.fromJson(responseData);
        Preferences preferences = Preferences();

        await preferences.saveUser(responseJson.result!);
      } else 
      {
        Preferences preferences = Preferences();
        preferences.clearPrefs();
      }
    } catch (error) {
      throw error;
    }
  }
}
