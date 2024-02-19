import 'dart:convert';
import 'dart:io';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/login/Loginresponse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cnattendance/utils/deviceuuid.dart';
import 'package:cnattendance/utils/constant.dart';

class Auth with ChangeNotifier {
  Future<Loginresponse> login(String username, String password) async {
    var uri = Uri.parse(Constant.LOGIN_URL);
    print("Login URL is - ");
    print(Constant.LOGIN_URL);

    Map<String, String> headers = {"Accept": "application/json; charset=UTF-8"};
    print("Header is :$headers");

    try {
      var fcm = await FirebaseMessaging.instance.getToken();
      print("FCM is :$fcm");

      Map<String, dynamic> Requestbody = {
        'username': username,
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

        ///Save UserData
        Preferences preferences = Preferences();

        await preferences.saveUser(responseJson.data);

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
}
