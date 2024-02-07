import 'package:cnattendance/provider/taskprovider.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:cnattendance/widget/task_status/completed_task_screen.dart';
import 'package:cnattendance/widget/task_status/pending_task_screen.dart';
import 'package:cnattendance/widget/task_status/pending_task_widegt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TaskStatusScreen extends StatefulWidget {
  const TaskStatusScreen({super.key});

  @override
  State<TaskStatusScreen> createState() => _TaskStatusScreenState();
}

class _TaskStatusScreenState extends State<TaskStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              //automaticallyImplyLeading: true,
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Get.back();
                },
              ),
              title: Center(
                child: Text(
                  "My Task Status",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_literals_to_create_immutables
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white12),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Container(
                          padding: EdgeInsets.only(bottom: 10),
                          color: Colors.transparent,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Text(
                              "Pending Task",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          )),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          color: Colors.transparent,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Text(
                              'Completed Task',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    ChangeNotifierProvider<MyTaskProvider>(
                        create: (BuildContext context) => MyTaskProvider(),
                        child: PendingTaskScreen()),
                    ChangeNotifierProvider<MyTaskProvider>(
                        create: (BuildContext context) => MyTaskProvider(),
                        child: CompletedTaskScreen()),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // DefaultTabController(
    //   length: 2,
    //   child: Container(
    //     decoration: RadialDecoration(),
    //     child: Scaffold(
    //       backgroundColor: Colors.transparent,
    //       appBar: AppBar(
    //         backgroundColor: Colors.transparent,
    //         //automaticallyImplyLeading: true,
    //         leading: InkWell(
    //           child: Icon(
    //             Icons.arrow_back_ios,
    //             color: Colors.white,
    //           ),
    //           onTap: () {
    //             Get.back();
    //           },
    //         ),
    //         bottom: TabBar(
    //           labelColor: Colors.red,
    //           unselectedLabelColor: Colors.transparent,
    //           // indicatorColor: Colors.transparent,

    //           tabs: [
    //             Container(
    //               padding: EdgeInsets.only(bottom: 10),
    //               color: Colors.transparent,
    //               child: Text(
    //                 "Pending Task",
    //                 style: TextStyle(color: Colors.blue, fontSize: 18),
    //               ),
    //             ),
    //             Container(
    //               padding: EdgeInsets.only(bottom: 10),
    //               color: Colors.transparent,
    //               child: Text(
    //                 'Completed Task',
    //                 style: TextStyle(color: Colors.green, fontSize: 18),
    //               ),
    //             ),
    //           ],
    //         ),
    //         title:
    // Center(
    //           child: Text(
    //             "My Task Status",
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //         actions: [],
    //       ),
    //       body: TabBarView(
    //         children: [
    //           ChangeNotifierProvider<MyTaskProvider>(
    //               create: (BuildContext context) => MyTaskProvider(),
    //               child: PendingTaskScreen()),
    //           ChangeNotifierProvider<MyTaskProvider>(
    //               create: (BuildContext context) => MyTaskProvider(),
    //               child: CompletedTaskScreen()),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
