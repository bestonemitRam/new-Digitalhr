import 'dart:convert';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/provider/prefprovider.dart';
import 'package:bmiterp/screen/dashboard/homescreen.dart';
import 'package:bmiterp/screen/dashboard/leaveandattendance_dash.dart';
import 'package:bmiterp/screen/dashboard/leavescreen.dart';
import 'package:bmiterp/screen/dashboard/attendancescreen.dart';
import 'package:bmiterp/screen/dashboard/morescreen.dart';
import 'package:bmiterp/screen/dashboard/projectscreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../utils/trackModel.dart';

class DashboardScreen extends StatefulWidget {
  //static const String routeName = '/';
  static const String routeName = '/dashboard';

  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  Position? _currentPosition;
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      ProjectScreen(),
      // LeaveScreen(),
      AttendanceScreenHistory(),
      // AttendanceScreen(),
      MoreScreen(),
    ];
  }

  @override
  void initState() {
    // checklocation();
    super.initState();
    _handleLocationPermission();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    print("djkgjkdfgkfjdfghkj");
    final prefProvider = Provider.of<PrefProvider>(context);
    // prefProvider.getUser();
    return Scaffold(
      body: PersistentTabView(context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          backgroundColor: HexColor("#041033"),
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style11),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_filled),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.work_history),
        title: "Work",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.sick),
        title: "Leave",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.co_present_outlined),
      //   title: "Attendance",
      //   activeColorPrimary: Colors.white,
      //   inactiveColorPrimary: Colors.white30,
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.more),
        title: "Menu",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
    ];
  }
}
