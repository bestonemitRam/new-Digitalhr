import 'package:bmiterp/map/google_map_screen.dart';
import 'package:bmiterp/provider/profileUserProvider.dart';
import 'package:bmiterp/provider/shopprovider.dart';
import 'package:bmiterp/provider/taskprovider.dart';
import 'package:bmiterp/screen/distributors/distributor_screen.dart';
import 'package:bmiterp/screen/genrateOrder/order_genrate_ui.dart';
import 'package:bmiterp/screen/profile/aboutscreen.dart';
import 'package:bmiterp/screen/profile/changepasswordscreen.dart';
import 'package:bmiterp/screen/profile/companyrulesscreen.dart';
import 'package:bmiterp/screen/profile/holidayscreen.dart';
import 'package:bmiterp/screen/profile/leavecalendarscreen.dart';
import 'package:bmiterp/screen/profile/meetingscreen.dart';
import 'package:bmiterp/screen/profile/new_profileScreen.dart';
import 'package:bmiterp/screen/profile/noticescreen.dart';
import 'package:bmiterp/screen/profile/payslipscreen.dart';
import 'package:bmiterp/screen/profile/profilescreen.dart';
import 'package:bmiterp/screen/profile/supportscreen.dart';
import 'package:bmiterp/screen/profile/teamsheetscreen.dart';
import 'package:bmiterp/screen/shop_module/shop_listing_screen.dart';
import 'package:bmiterp/screen/tadascreen/TadaScreen.dart';
import 'package:bmiterp/widget/headerprofile.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:bmiterp/widget/task_status/task_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:bmiterp/widget/morescreen/services.dart';
import 'package:bmiterp/widget/morescreen/securitycheck.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
                    'Retailers',
                    Icons.shop,
                    ChangeNotifierProvider<ShopProvider>(
                        create: (BuildContext context) => ShopProvider(),
                        child: ShopListingScreen())),
                Services(
                    'Map Area',
                    Icons.shop,
                    ChangeNotifierProvider<ShopProvider>(
                        create: (BuildContext context) => ShopProvider(),
                        child: GoogleMapScreen())),

                Services(
                    'Distributors',
                    Icons.takeout_dining_outlined,
                    ChangeNotifierProvider<ShopProvider>(
                        create: (BuildContext context) => ShopProvider(),
                        child: DistributorScreen())),

                Services(
                    'Create Order',
                    Icons.shop,
                    ChangeNotifierProvider<ShopProvider>(
                        create: (BuildContext context) => ShopProvider(),
                        child: OrderGenerate())),
                Services('My Task', Icons.group_work_sharp, TaskStatusScreen()),
                Services('TA / DA', Icons.money, TadaScreen()),

                //Services('Issue Ticket', Icons.note, ProfileScreen()),
                //  Services('Company Rules', Icons.rule_folder, CompanyRulesScreen()),

                // Services('Meeting', Icons.meeting_room, MeetingScreen()),
                //Services('Pay Slip', Icons.payments_rounded, PaySlipScreen()),
                Services('Holiday', Icons.calendar_month, HolidayScreen()),
                // Services('Team Sheet', Icons.group, TeamSheetScreen()),
                // Services('Leave Calendar', Icons.calendar_month_outlined,LeaveCalendarScreen()),
                // Services('Notices', Icons.message, NoticeScreen()),
                // Services('Support', Icons.support_agent, SupportScreen()),
                Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 5),
                  child: Text(
                    "Additional",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Services(
                    'Change Password', Icons.password, ChangePasswordScreen()),
                //Services('About Us', Icons.info, AboutScreen('about-us')),
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
