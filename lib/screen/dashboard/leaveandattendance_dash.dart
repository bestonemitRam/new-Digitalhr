import 'package:bmiterp/provider/taskprovider.dart';
import 'package:bmiterp/screen/dashboard/attendancescreen.dart';
import 'package:bmiterp/screen/dashboard/leavescreen.dart';
import 'package:bmiterp/widget/headerprofile.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:bmiterp/widget/task_status/completed_task_screen.dart';
import 'package:bmiterp/widget/task_status/pending_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AttendanceScreenHistory extends StatefulWidget {
  const AttendanceScreenHistory({super.key});

  @override
  State<AttendanceScreenHistory> createState() => _TaskStatusScreenState();
}

class _TaskStatusScreenState extends State<AttendanceScreenHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                HeaderProfile(),
                SizedBox(
                  height: 2.h,
                ),
                SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      child: TabBar(
                        // Set this to true for scrollable tabs
                        indicator: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Text(
                                  "Leave",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              //   color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Text(
                                  'Attendance History',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      TabBarView(children: [LeaveScreen(), AttendanceScreen()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
