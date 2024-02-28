import 'dart:convert';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/data/source/network/connect.dart';
import 'package:bmiterp/data/source/network/model/attendancereport/AttendanceReportResponse.dart';
import 'package:bmiterp/utils/constant.dart';

class AttendanceReportRepository {
  Future<AttendanceReportResponse> getAttendanceReport(
      int selectedMonth) async {
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    try {
      final response = await Connect().getResponse(
          APIURL.ATTENDANCC_HISTORY + "${selectedMonth + 1}", headers);

      final responseData = json.decode(response.body);

      final responseJson = AttendanceReportResponse.fromJson(responseData);
      print("kdjfhgkjdfgkj  ${responseData} ${response.statusCode}");

      if (response.statusCode == 200) {
        print(responseData.toString());

        return responseJson;
      } 
      else {
        var errorMessage = responseData['message'];
        //throw errorMessage;
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }
}
