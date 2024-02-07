import 'package:cnattendance/provider/profileUserProvider.dart';
import 'package:cnattendance/provider/taskprovider.dart';
import 'package:cnattendance/screen/profile/aboutscreen.dart';
import 'package:cnattendance/screen/profile/changepasswordscreen.dart';
import 'package:cnattendance/screen/profile/companyrulesscreen.dart';
import 'package:cnattendance/screen/profile/holidayscreen.dart';
import 'package:cnattendance/screen/profile/leavecalendarscreen.dart';
import 'package:cnattendance/screen/profile/meetingscreen.dart';
import 'package:cnattendance/screen/profile/new_profileScreen.dart';
import 'package:cnattendance/screen/profile/noticescreen.dart';
import 'package:cnattendance/screen/profile/payslipscreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/screen/profile/supportscreen.dart';
import 'package:cnattendance/screen/profile/teamsheetscreen.dart';
import 'package:cnattendance/screen/tadascreen/TadaScreen.dart';
import 'package:cnattendance/widget/headerprofile.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:cnattendance/widget/task_status/task_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:cnattendance/widget/morescreen/services.dart';
import 'package:cnattendance/widget/morescreen/securitycheck.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderProfile(),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Services',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                Services(
                    'Profile',
                    Icons.person,
                    ChangeNotifierProvider<ProfileUserProvider>(
                        create: (BuildContext context) => ProfileUserProvider(),
                        child: ProfileScreenActivity())),
                // Services('Profile', Icons.password, ProfileScreen()),

                Services(
                    'Change Password', Icons.password, ChangePasswordScreen()),
                Services('Meeting', Icons.meeting_room, MeetingScreen()),
                //Services('Pay Slip', Icons.payments_rounded, PaySlipScreen()),
                Services('Holiday', Icons.calendar_month, HolidayScreen()),
                Services('Team Sheet', Icons.group, TeamSheetScreen()),
                Services('Leave Calendar', Icons.calendar_month_outlined,
                    LeaveCalendarScreen()),
                Services('Notices', Icons.message, NoticeScreen()),
                Services('Support', Icons.support_agent, SupportScreen()),
                Services('TADA', Icons.money, TadaScreen()),
                const Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 10),
                    child: Text(
                      'Additional',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                //Services('Issue Ticket', Icons.note, ProfileScreen()),
                Services(
                    'Company Rules', Icons.rule_folder, CompanyRulesScreen()),
                Services('My Task', Icons.rule_folder, TaskStatusScreen()),

                Services('About Us', Icons.info, AboutScreen('about-us')),
                Services('Terms and Conditions', Icons.rule,
                    AboutScreen('terms-and-conditions')),
                Services('Privacy Policy', Icons.policy, ProfileScreen()),
                SecurityCheck('Security Check', Icons.security, ''),
                Services('Log Out', Icons.logout, ProfileScreen()),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
