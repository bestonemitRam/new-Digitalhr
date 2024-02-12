import 'dart:convert';

import 'package:cnattendance/api/apiConstant.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/data/source/network/model/leavetype/LeaveType.dart';
import 'package:cnattendance/data/source/network/model/leavetype/Leavetyperesponse.dart';
import 'package:cnattendance/data/source/network/model/leavetypedetail/LeaveTypeDetail.dart';
import 'package:cnattendance/data/source/network/model/leavetypedetail/Leavetypedetailreponse.dart';
import 'package:cnattendance/model/LeaveDetail.dart';
import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/model/select_leave_model.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cnattendance/data/source/datastore/preferences.dart';

class LeaveProvider with ChangeNotifier {
  final List<Leave> _leaveList = [];
  final List<Leave> _selectleaveList = [];
  final List<LeaveDetail> _leaveDetailList = [];

  var _selectedMonth = 0;
  var _selectedType = 0;

  int get selectedMonth {
    return _selectedMonth;
  }

  void setMonth(int value) {
    _selectedMonth = value;
  }

  int get selectedType {
    return _selectedType;
  }

  void setType(int value) {
    _selectedType = value;
  }

  List<Leave> get leaveList {
    return [..._leaveList];
  }

  List<Leave> get selectleaveList {
    return [..._selectleaveList];
  }

  List<LeaveDetail> get leaveDetailList {
    return [..._leaveDetailList];
  }

  Future<Leavetyperesponse> getLeaveType() async {
    print("dfgdfgdfgjdfgjh");
    var uri = Uri.parse(APIURL.BUUCKET_LEAVE);

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
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);

      print("Check leave data ${responseData}");

      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = Leavetyperesponse.fromJson(responseData);
        makeLeaveList(responseJson.data!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void makeLeaveList(Data data) {
    _leaveList.clear();

    for (var leave in data.leaveTypeData!) {
      _leaveList.add(Leave(
          id: int.parse(leave.id.toString() ?? '0'),
          name: leave.leaveTypeName!,
          allocated: int.parse(leave.taken.toString() ?? "0"),
          total: int.parse(leave.available.toString() ?? "0"),
          status: true,
          isEarlyLeave: true));
    }

    notifyListeners();
  }

  Future<SelectLeaveTypeModel> selectLeaveType() async {
    var uri = Uri.parse(APIURL.SELECT_LEAVE_API);

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
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);

      print("Check leafdgdfgdfve data ${responseData}");

      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = SelectLeaveTypeModel.fromJson(responseData);
        selectLeaveList(responseJson.data!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void selectLeaveList(Datas data) {
    _selectleaveList.clear();

    for (var leave in data.leaveTypeList!) {
      _selectleaveList.add(Leave(
          id: int.parse(leave.leaveTypeId.toString() ?? '0'),
          name: leave.leaveTypeName!,
          allocated: int.parse("0"),
          total: int.parse(leave.available.toString() ?? "0"),
          status: true,
          isEarlyLeave: true));
    }

    notifyListeners();
  }

  Future<Leavetypedetailreponse> getLeaveTypeDetail() async {
    var uri = Uri.parse(APIURL.LEAVE_LIST_DETAILS_API +
        "${_selectedMonth == 0 ? "year" : "month"}/${_selectedType}");

    //     .replace(queryParameters:
    //     {
    //     'month': _selectedMonth == 0 ? _selectedMonth.toString() : '',
    //     'leave_type': _selectedType != 0 ? _selectedType.toString() : '',
    // });

    // var uri =
    //     Uri.parse(APIURL.LEAVE_LIST_DETAILS_API).replace(queryParameters: {
    //   'month': _selectedMonth != 0 ? _selectedMonth.toString() : '',
    //   'leave_type': _selectedType != 0 ? _selectedType.toString() : '',
    // });

    print("check leave details ${uri}     ${_selectedMonth}");

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
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      print("check api response ${responseData}");
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = Leavetypedetailreponse.fromJson(responseData);
        print("check pase data in model ${responseJson}");

        makeLeaveTypeList(responseJson.data!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void makeLeaveTypeList(LeaveData leaveList) {
    _leaveDetailList.clear();

    for (var leave in leaveList.leaveList!)
     {
      _leaveDetailList.add(LeaveDetail(
          id: leave.id!,
          name: leave.leaveTypeName!,
          leave_from: leave.leaveFrom!,
          leave_to: leave.leaveTo!,
          requested_date: '',
          authorization: leave.status!,
          status: leave.status!));
    }

    notifyListeners();
  }

  Future<IssueLeaveResponse> issueLeave(
      String from, String to, String reason, int leaveId) async {
    var uri = Uri.parse(APIURL.LEAVE_REQUEST_API);

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
      final response = await http.post(uri, headers: headers, body: {
        'leave_from': from,
        'leave_to': to,
        'leave_type_id': leaveId.toString(),
        'leave_reason': reason,
      });

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = IssueLeaveResponse.fromJson(responseData);

        debugPrint(responseJson.toString());
        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }

  Future<IssueLeaveResponse> cancelLeave(int leaveId) async {
    var uri = Uri.parse(Constant.CANCEL_LEAVE + "/$leaveId");

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = IssueLeaveResponse.fromJson(responseData);

        debugPrint(responseJson.toString());
        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      debugPrint(error.toString());
      throw error;
    }
  }
}
