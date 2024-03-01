import 'dart:async';

import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/model/auth.dart';
import 'package:bmiterp/screen/auth/login_screen.dart';
import 'package:bmiterp/screen/dashboard/dashboard_screen.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 1000),
      () async {
        Preferences preferences = Preferences();
        String result = await preferences.getToken();
        if (result == '') {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
        }
      },
    );
    super.initState();
  }
   Future<String> loadAttendanceReport() async {
    try {
      final response = await Provider.of<Auth>(context, listen: false).getMe();

      return 'loaded';
    } catch (e) {
      return 'loaded';
    }
  }

  @override
  void didChangeDependencies() 
  { loadAttendanceReport();
    super.didChangeDependencies();
  }

 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Center(
          child: Image.asset(
        "assets/icons/logo_bnw.png",
        width: 120,
        height: 120,
      )),
    );
  }
}
