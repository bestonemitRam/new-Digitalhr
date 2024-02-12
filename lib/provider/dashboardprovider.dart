import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_location/background_location.dart';
import 'package:cnattendance/api/apiConstant.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/attendancestatus/AttendanceStatusResponse.dart';
import 'package:cnattendance/data/source/network/model/dashboard/Dashboardresponse.dart';
import 'package:cnattendance/data/source/network/model/dashboard/EmployeeTodayAttendance.dart';
import 'package:cnattendance/data/source/network/model/dashboard/Overview.dart';
import 'package:cnattendance/main.dart';
import 'package:cnattendance/model/home_page_model.dart';
import 'package:cnattendance/utils/background_services.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:cnattendance/utils/locationstatus.dart';
import 'package:cnattendance/utils/wifiinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import '../utils/trackModel.dart';

class DashboardProvider with ChangeNotifier {
  Timer? _timer;
  final Map<String, String> _overviewList = {
    'present': '0',
    'holiday': '0',
    'leave': '0',
    'request': '0',
    'total_project': '0',
    'total_task': '0',
  };

  final Map<String, double> locationStatus = {
    'latitude': 0.0,
    'longitude': 0.0,
  };

  Map<String, String> get overviewList {
    return _overviewList;
  }

  final Map<String, dynamic> _attendanceList = {
    'check-in': '-',
    'check-out': '-',
    'production_hour': '0 hr 0 min',
    'production-time': 0.0
  };
  Map<String, dynamic> get attendanceList {
    return _attendanceList;
  }

  final List<int> _weeklyReport = [];
  List<int> get weeklyReport {
    return _weeklyReport;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<BarChartGroupData> barchartValue = [];
  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  void buildgraph() {
    const int daysInWeek = 7;
    for (int i = 0; i < daysInWeek; i++) {
      barchartValue.add(makeGroupData(i, 0));
    }
    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);
  }

  Future<Dashboardresponse> getDashboard() async {
    var uri = Uri.parse(Constant.DASHBOARD_URL);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    print("Dasboard API token is - :$token");
    var fcm = await FirebaseMessaging.instance.getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'fcm_token': fcm ?? ""
    };
    print("Dasboard API token is - :$token");
    try {
      final response = await http.get(uri, headers: headers);
      debugPrint(response.body.toString());
      final responseData = json.decode(response.body);

      print("fdjgkjfgk  ${response.statusCode}");

      if (response.statusCode == 200) {
        final dashboardResponse = Dashboardresponse.fromJson(responseData);
        debugPrint(dashboardResponse.toString());
        //updateAttendanceStatus(dashboardResponse.data.employeeTodayAttendance);
        // updateOverView(dashboardResponse.data.overview);
        makeWeeklyReport(dashboardResponse.data.employeeWeeklyReport);
        DateTime startTime = DateFormat("hh:mm a")
            .parse(dashboardResponse.data.officeTime.startTime);
        DateTime endTime = DateFormat("hh:mm a")
            .parse(dashboardResponse.data.officeTime.endTime);

        await AwesomeNotifications().cancelAllSchedules();
        for (var shift in dashboardResponse.data.shift_dates) {
          scheduleNewNotification(shift, "Please check in on time ⏱️⌛️",
              startTime.hour, startTime.minute);
          scheduleNewNotification(
              shift,
              "Almost done with your shift 😄⌛️ Remember to checkout ⏱️",
              endTime.hour,
              endTime.minute);
        }
        return dashboardResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<HomeScreenModel> getDashboardData() async {
    var uri = Uri.parse(APIURL.HOME_PAGE_URL);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();

    var fcm = await FirebaseMessaging.instance.getToken();

    int getUserID = await preferences.getUserId();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    print("Dasboard API token is - :$token");
    try {
      final response = await http.get(uri, headers: headers);
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      print("fdjgkjfgk  ${response.statusCode}  ${responseData}");

      if (response.statusCode == 200) {
        final dashboardResponse = HomeScreenModel.fromJson(responseData);
        debugPrint(dashboardResponse.toString());
        updateOverView(dashboardResponse.data!.counts!);
        updateAttendanceStatus(dashboardResponse.data!.employeeAttendanceData!);

        // makeWeeklyReport(dashboardResponse.data.employeeAttendanceData!);
        DateTime startTime = DateFormat("hh:mm a")
            .parse(dashboardResponse.data!.officeData!.openingTime);
        DateTime endTime = DateFormat("hh:mm a")
            .parse(dashboardResponse.data!.officeData!.closingTime);
        await AwesomeNotifications().cancelAllSchedules();
        // for (var shift in dashboardResponse.data.shift_dates)
        //  {
        //   scheduleNewNotification(shift, "Please check in on time ⏱️⌛️",  startTime.hour, startTime.minute);
        //   scheduleNewNotification(
        //       shift,
        //       "Almost done with your shift 😄⌛️ Remember to checkout ⏱️",
        //       endTime.hour,
        //       endTime.minute);
        // }
        return dashboardResponse;
      } else {
        var errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      throw e;
    }
  }

  void makeWeeklyReport(List<dynamic> employeeWeeklyReport) {
    _weeklyReport.clear();
    for (var item in employeeWeeklyReport) {
      if (item != null) {
        int hr = (item['productive_time_in_min'] / 60).toInt();
        if (hr > Constant.TOTAL_WORKING_HOUR) {
          _weeklyReport.add(Constant.TOTAL_WORKING_HOUR);
        } else {
          _weeklyReport.add(hr);
        }
      } else {
        _weeklyReport.add(0);
      }
    }

    barchartValue.clear();
    rawBarGroups.clear();
    showingBarGroups.clear();
    for (int i = 0; i < _weeklyReport.length; i++) {
      barchartValue.add(makeGroupData(i, _weeklyReport[i].toDouble()));
    }
    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);
    notifyListeners();
  }

  void updateAttendanceStatus(EmployeeAttendanceData employeeTodayAttendance) {
    _attendanceList.update('production-time',
        (value) => calculateProdHour(employeeTodayAttendance.productionTime));
    _attendanceList.update(
        'check-out', (value) => employeeTodayAttendance.checkOut);
    _attendanceList.update('production_hour',
        (value) => calculateHourText(employeeTodayAttendance.productionHour));
    _attendanceList.update(
        'check-in', (value) => employeeTodayAttendance.checkIn);
    notifyListeners();
  }

  void updateOverView(Counts overview) {
    print("djgkfgkjhh  ${overview.holidayCount.toString()}");
    _overviewList.update(
        'present', (value) => overview.presentCount.toString());

    _overviewList.update(
        'holiday', (value) => overview.holidayCount.toString());
    _overviewList.update('leave', (value) => overview.leaveCount.toString());
    _overviewList.update('request', (value) => overview.leaveCount.toString());
    _overviewList.update(
        'total_project', (value) => overview.leaveCount.toString());
    _overviewList.update(
        'total_task', (value) => overview.taskCount.toString());
    notifyListeners();
  }

  double calculateProdHour(int value) {
    double hour = value / 60;
    double hr = hour / Constant.TOTAL_WORKING_HOUR;
    return hr > 1 ? 1 : hr;
  }

  String calculateHourText(int value) {
    double second = value * 60.toDouble();
    double min = second / 60;
    int minGone = (min % 60).toInt();
    int hour = min ~/ 60;
    print("$hour hr $minGone min");
    return "$hour hr $minGone min";
  }

  Future<bool> getCheckInStatus() async {
    try {
      final position = await LocationStatus().determinePosition();
      locationStatus.update('latitude', (value) => position.latitude);
      locationStatus.update('longitude', (value) => position.longitude);
      if (locationStatus['latitude'] != 0.0 &&
          locationStatus['longitude'] != 0.0) {
        return true;
      } else {
        Future.error(
            'Location is not detected. Please check if location is enabled and try again.');
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  ///MARK: - CHECK-IN API IMPLEMENTATION
  Future<AttendanceStatusResponse> checkInAttendance() async {
    print("Inside the Check In Api Statements");
    var uri = Uri.parse(Constant.CHECK_IN_URL);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    var fcm = await FirebaseMessaging.instance.getToken();
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    Map<String, dynamic> body = {
      'attendance_date': currentDate.toString(),
      'check_in_at': currentTime.toString(),
      'check_in_latitude': locationStatus['latitude'].toString(),
      'check_in_longitude': locationStatus['longitude'].toString(),
    };

    try {
      final response = await http.post(uri, headers: headers, body: body);
      final responseData = json.decode(response.body);

      print("djhgfghjfgh  ${responseData['status']}  ${response.body}");
      final attendanceResponse =
          AttendanceStatusResponse.fromJson(responseData);

      if (responseData['status'] == true) {
        bgLocationTask();

        updateAttendanceStatus(EmployeeAttendanceData(
            checkIn: attendanceResponse.data.checkInAt.toString(),
            checkOut: attendanceResponse.data.checkOutAt.toString(),
            productionTime:
                attendanceResponse.data.productiveTimeInMin.toString()));

        return attendanceResponse;
      } else {
        //  _timer =  Timer.periodic(Duration(seconds:10), (Timer timer)
        //  {

        //    getCurrentPosition();
        //     checkOutAttendance();

        //    });

        print("lkfhjdgkfgk  ${responseData['message']}");
        var errorMessage = responseData['message'];
        return attendanceResponse;
      }
    } catch (e) {
      debugPrint(locationStatus['latitude'].toString());
      debugPrint(locationStatus['longitude'].toString());
      debugPrint(await WifiInfo().wifiBSSID() ?? "");
      rethrow;
    }
  }

  Future<void> bgLocationTask() async {
    BackgroundLocation.startLocationService();
    initBackgroundLocation();

    try {
      final backgroundApiViewModel = DashboardProvider();

      Timer.periodic(Duration(minutes: 1), (Timer t) async {
        print("Calling getCurrentPosition within Timer");

        backgroundApiViewModel.getCurrentPosition();
      });
    } catch (err, stackTrace) {
      print("This is the error: $err");
      print("Stacktrace : ${stackTrace}");
      throw Exception(err.toString());
    }
  }

  void stopLocationService() {
    print("stop service");
    BackgroundLocation.stopLocationService();
  }

  void initBackgroundLocation() {
    BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) {
      print("Location: ${location.latitude}, ${location.longitude}");
    });
  }

  ///MARK: - Schedule Notification
  Future<void> scheduleNewNotification(
      String date, String message, int hour, int minute) async {
    final convertedDate = new DateFormat('yyyy-MM-dd').parse(date);

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(1000000),
            // -1 is replaced by a random number
            channelKey: 'digital_hr_channel',
            title: "Hello There",
            body: message,
            //'asset://assets/images/balloons-in-sky.jpg',
            notificationLayout: NotificationLayout.Default,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
              key: 'REDIRECT', label: 'Open', actionType: ActionType.Default),
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ],
        schedule: NotificationCalendar.fromDate(
            date: DateTime(convertedDate.year, convertedDate.month,
                convertedDate.day, hour, minute - 15)));
  }

  checklocation(double lat, double long) async {
    print("dkfgjkfcdsjghkjgh");
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    Map<String, dynamic> body = {
      'tracker_latitude': lat,
      'tracker_longitude': long,
    };
    var uri = await Uri.parse(
        'https://bsoe.meestdrive.in/api/employees/currentLocationSave');
    try {
      final response = await http.post(uri, headers: headers, body: {
        "tracker_latitude": lat.toString(),
        "tracker_longitude": long.toString()
      });
      debugPrint('resp   ${response.body.toString()}');
      final responseData = json.encode(response.body);
      print('response---->${responseData}');
    } catch (e) {
      print('exphfiuer$e');
    }
  }

  Future<void> getCurrentPosition() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;

      if (result == true) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print("latLongsddd ${position.longitude} ${position.latitude}");
        checklocation(position.longitude, position.latitude);
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print("latLongsddd ${position.longitude} ${position.latitude}");
        await dbHelper.insertLocationData(position.latitude!,
            position.longitude!, DateTime.now().millisecondsSinceEpoch);

        print(
            "dsdsfdfgfhgfh ${InternetConnectionChecker().hasConnection}  ${position.longitude} ${position.latitude} 1");
      }
    } catch (e, stT) {
      print("Error getting current position: $e");
      print("StackTrace: $stT");
      // Handle the error accordingly
      checklocation(0.0, 0.0);
    }
  }

  ///MARK: - CheckOut API Implementation
  Future<AttendanceStatusResponse> checkOutAttendance() async {
    print("dkfjhgkljfghkfgk   ");
    var uri = Uri.parse(Constant.CHECK_OUT_URL);
    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    print("CurrentDate  is - : ${currentDate.toString()}");
    print("CurrentTime  is - : ${currentTime.toString()}");
    var fcm = await FirebaseMessaging.instance.getToken();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };

    Map<String, dynamic> body = {
      'attendance_date': currentDate.toString(),
      'check_out_at': currentTime.toString(),
      'check_out_latitude': locationStatus['latitude'].toString(),
      'check_out_longitude': locationStatus['longitude'].toString(),
    };
    print("LogOut Request is :$body  ${headers}");
    try {
      final response = await http.post(uri, headers: headers, body: body);
      debugPrint(response.body.toString());
      final responseData = json.decode(response.body);

      final attendanceResponse =
          AttendanceStatusResponse.fromJson(responseData);

      print("klfgjhkjhfgkh  ${responseData}   ${attendanceResponse}");

      if (response.statusCode == 200) {
        stopLocationService();
        if (responseData['status'] == true) {
          updateAttendanceStatus(EmployeeAttendanceData(
              checkIn: attendanceResponse.data.checkInAt.toString(),
              checkOut: attendanceResponse.data.checkOutAt.toString(),
              productionTime:
                  attendanceResponse.data.productiveTimeInMin.toString()));
        }

        return attendanceResponse;
      } else {
        var errorMessage = responseData['message'];
        return attendanceResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  final Color leftBarColor = HexColor("#FFFFFF");
  final double width = 15;

  ///MARK: -BarChart Data
  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: width,
      ),
    ]);
  }
}
