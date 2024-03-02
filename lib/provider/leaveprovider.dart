import 'dart:convert';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:bmiterp/data/source/network/model/leavetype/LeaveType.dart';
import 'package:bmiterp/data/source/network/model/leavetype/Leavetyperesponse.dart';
import 'package:bmiterp/data/source/network/model/leavetypedetail/LeaveTypeDetail.dart';
import 'package:bmiterp/data/source/network/model/leavetypedetail/Leavetypedetailreponse.dart';
import 'package:bmiterp/data/source/network/model/retailer/reatailer_model.dart';
import 'package:bmiterp/model/LeaveDetail.dart';
import 'package:bmiterp/model/leave.dart';
import 'package:bmiterp/model/select_leave_model.dart';
import 'package:bmiterp/model/shop.dart';
import 'package:bmiterp/model/shopresponse.dart';
import 'package:bmiterp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        final response = await http.get(uri, headers: headers);

        final responseData = json.decode(response.body);

        print("Check leave data ${responseData}");

        if (response.statusCode == 200) {
          debugPrint(responseData.toString());

          final responseJson = Leavetyperesponse.fromJson(responseData);
          makeLeaveList(responseJson.result!);

          return responseJson;
        } else {
          var errorMessage = responseData['message'];
          throw errorMessage;
        }
      } catch (error) {
        throw error;
      }
    } else {
      var errorMessage = "Please check your internet connection! ";
      throw errorMessage;
    }
  }

  void makeLeaveList(Data data) {
    _leaveList.clear();

    for (var leave in data.leavesData!) {
      _leaveList.add(Leave(
          id: int.parse('0'),
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
    print('dlsfjkghkgfhkhdfgkj');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);

      print("Check leafdgdfgfddfdfve data ${responseData}");

      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = SelectLeaveTypeModel.fromJson(responseData);
        selectLeaveList(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void selectLeaveList(Result data) {
    _selectleaveList.clear();

    for (var leave in data.leaveTypes!) {
      _selectleaveList.add(Leave(
          id: int.parse(leave.id.toString() ?? '0'),
          name: leave.leaveTypeName!,
          allocated: int.parse("0"),
          total: int.parse("0"),
          status: true,
          isEarlyLeave: true));
    }

    notifyListeners();
  }

  Future<Leavetypedetailreponse> getLeaveTypeDetail() async {
    var uri;

    if (_selectedType == 0) {
      uri = Uri.parse(APIURL.LEAVE_LIST_DETAILS_API +
          "fetchType=${_selectedMonth == 0 ? "year" : "month"}");
    } else {
      uri = Uri.parse(APIURL.LEAVE_LIST_DETAILS_API +
          "fetchType=${_selectedMonth == 0 ? "year" : "month"}&leaveTypeID=${_selectedType}");
    }

    print("dfgfdfggfdh  ${uri}");

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

    print("check leave detailsd ${uri}     ${_selectedMonth}");

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
      print("check api dsfdfresponse ${responseData}");
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = Leavetypedetailreponse.fromJson(responseData);
        print("check pase data in model ${responseJson}");

        makeLeaveTypeList(responseJson!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      throw error;
    }
  }

  void makeLeaveTypeList(Leavetypedetailreponse leaveList) {
    _leaveDetailList.clear();

    for (var leave in leaveList.result!) {
      _leaveDetailList.add(LeaveDetail(
          id: 1,
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
        'reason': reason,
      });

      final responseData = json.decode(response.body);

      print("checkData  ${responseData} ${response.statusCode}");
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

  final List<Shop> _shoplist = [];

  List<Shop> get shoplist {
    return [..._shoplist];
  }

  Future<RetailerModel> getShopList() async {
    print("check get all shop list data ");
    var uri = Uri.parse(APIURL.GET_RETAILER_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    bool result = await InternetConnectionChecker().hasConnection;

    if (result == true) {
      try {
        EasyLoading.show(
            status: "Loading", maskType: EasyLoadingMaskType.black);
        final response = await http.get(uri, headers: headers);
        final responseData = json.decode(response.body);

        print("Check leave data ${responseData}");
        final responseJson = RetailerModel.fromJson(responseData);
        if (response.statusCode == 200) 
        {
          debugPrint(responseData.toString());

          makeShopList(responseJson.result!);
          EasyLoading.dismiss(animation: true);

          return responseJson;
        } else {
          EasyLoading.dismiss(animation: true);
          var errorMessage = responseData['message'];
          return responseJson;
        }
      } catch (error) {
        EasyLoading.dismiss(animation: true);
        throw error;
      }
    } else {
      EasyLoading.dismiss(animation: true);
      var errorMessage = "Please check your internet connection! ";
      throw errorMessage;
    }
  }

  void makeShopList(ResultData data) {
    _shoplist.clear();

    print("dfgjkfgh    ${data.retailersList}");

    for (var shop in data.retailersList!) {
      _shoplist.add(Shop(
          id: int.parse(shop.id.toString() ?? '0'),
          retailerName: shop.retailerName ?? " "!,
          retailerShopName: shop.retailerShopName ?? " "!,
          retailerAddress: shop.retailerAddress ?? " "!,
          retailerLatitude: shop.retailerLatitude ?? " "!,
          retailerLongitude: shop.retailerLongitude ?? " "!,
          retailerShopImage: shop.retailerShopImage ?? " "!,
          isVarified: shop.isVarified ?? 0!));
    }

    notifyListeners();
  }
}
