import 'dart:convert';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/data/source/network/model/logout/Logoutresponse.dart';
import 'package:bmiterp/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoreScreenProvider with ChangeNotifier {
  Future<Logoutresponse> logout() async {
    var uri = Uri.parse(APIURL.LOG_OUT);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();

    print("Get user token is :$token");
    print("Get user id  is :$getUserID");

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    print("Header is :$headers");

    try {
      final response = await http.get(uri, headers: headers);
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 401) {
        final jsonResponse = Logoutresponse.fromJson(responseData);
        print("Logout is Successfully");
        preferences.clearPrefs();
        return jsonResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }
}
