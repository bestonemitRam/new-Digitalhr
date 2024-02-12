import 'dart:async';

import 'package:cnattendance/data/source/network/model/login/User.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:cnattendance/utils/locationstatus.dart';
import 'package:cnattendance/widget/homescreen/checkattendance.dart';
import 'package:cnattendance/widget/homescreen/overviewdashboard.dart';
import 'package:cnattendance/widget/homescreen/weeklyreportchart.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:provider/provider.dart';
import 'package:cnattendance/widget/headerprofile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  late DashboardProvider dashboardResponse;
  void initState() {
    super.initState();
    // initializeService();
    dashboardResponse = Provider.of<DashboardProvider>(context, listen: false);
  }
  //
  // Future<void> initializeService() async {
  //   final service = FlutterBackgroundService();
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will executed when app is in foreground or background in separated isolate
  //       onStart: onStart,
  //
  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       // auto start service
  //       autoStart: true,
  //
  //       // this will executed when app is in foreground in separated isolate
  //       onForeground: onStart,
  //       onBackground:
  //       onStart ,
  //
  //       // you have to enable background fetch capability on xcode project
  //       // onBackground: onIosBackground,
  //     ),
  //   );
  // }

  //
  // void onStart() {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final service = FlutterBackgroundService();
  //   service.onDataReceived.listen((event) {
  //     if (event!["action"] == "setAsForeground") {
  //       service.setForegroundMode(true);
  //       return;
  //     }
  //
  //     if (event["action"] == "setAsBackground")
  //     {
  //       service.setForegroundMode(false);
  //     }
  //
  //     if (event["action"] == "stopService") {
  //       service.stopBackgroundService();
  //     }
  //   });
  //
  //   // bring to foreground
  //   service.setForegroundMode(true);
  //   Timer.periodic(Duration(seconds: 1), (timer) async
  //   {
  //     if (!(await service.isServiceRunning())) timer.cancel();
  //     service.setNotificationInfo(
  //       title: "My App Service",
  //       content: "Updated at ${DateTime.now()}",
  //     );
  //
  //     service.sendData(
  //       {"current_date": DateTime.now().toIso8601String()},
  //     );
  //   });
  // }

  void didChangeDependencies() {
    loadDashboard();
    locationStatus();
    super.didChangeDependencies();
  }

  void locationStatus() async {
    try {
      final position = await LocationStatus().determinePosition();

      if (!mounted) {
        return;
      }
      final location =
          Provider.of<DashboardProvider>(context, listen: false).locationStatus;
      location.update('latitude', (value) => position.latitude);
      location.update('longitude', (value) => position.longitude);
    } catch (e) {
      print(e);
      showToast(e.toString());
    }
  }

  Future<String> loadDashboard() async {
    var fcm = await FirebaseMessaging.instance.getToken();
    print(fcm);
    try {
      // final dashboardResponse =
      //     await Provider.of<DashboardProvider>(context, listen: false)
      //         .getDashboard();
      final dashboardProvider =
          await Provider.of<DashboardProvider>(context, listen: false)
              .getDashboardData();

      // final user = dashboardResponse.data.user;
      // Provider.of<PrefProvider>(context, listen: false).saveBasicUser(User(
      //     id: user.id,
      //     name: user.name,
      //     email: user.email,
      //     username: user.username,
      //     avatar: user.avatar));
      return 'loaded';
    } catch (e) {
      print(e);
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    // FlutterBackgroundService()
    //     .sendData({"action": "setAsBackground"});
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: Colors.white,
          backgroundColor: Colors.blueGrey,
          edgeOffset: 50,
          onRefresh: () {
            return loadDashboard();
          },
          child: SafeArea(
              child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  HeaderProfile(),
                  CheckAttendance(),
                  OverviewDashboard(),
                  WeeklyReportChart()
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
