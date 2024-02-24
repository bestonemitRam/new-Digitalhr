import 'dart:io';

import 'package:bmiterp/provider/profileUserProvider.dart';
import 'package:bmiterp/screen/profile/editprofilescreen.dart';
import 'package:bmiterp/utils/check_internet_connectvity.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:url_launcher/url_launcher.dart';

class ProfileScreenActivity extends StatefulWidget {
  const ProfileScreenActivity({super.key});

  @override
  State<ProfileScreenActivity> createState() => _ProfileScreenActivityState();
}

class _ProfileScreenActivityState extends State<ProfileScreenActivity> {
  ProfileUserProvider _profileuserProvider = ProfileUserProvider();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();

    _profileuserProvider =
        Provider.of<ProfileUserProvider>(context, listen: false);
    _profileuserProvider.profileuserlist();
  }

  bool showpop = false;
  bool light = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit_note,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProfileScreen.routeName);
                },
              )
            ],
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Get.back();
              },
            ),
          ),
         
          resizeToAvoidBottomInset: true,
          body: Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected
              ? InternetNotAvailable()
              : Consumer<ProfileUserProvider>(
                  builder: ((context, profileUserProvider, child) {
                  return profileUserProvider.datanotfound
                      ? profileUserProvider.profileuserList.isNotEmpty
                          ? SingleChildScrollView(
                              child: Container(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 6.5.h,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 6.h,
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.3),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 5.5.h,
                                              backgroundImage:
                                                  profileUserProvider
                                                              .profileuserList[
                                                                  0]
                                                              .avatar !=
                                                          null
                                                      ? NetworkImage(
                                                          profileUserProvider
                                                              .profileuserList[
                                                                  0]
                                                              .avatar!)
                                                      : AssetImage(
                                                          'assets/images/dummy_avatar.png',
                                                        ) as ImageProvider,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            profileUserProvider
                                                    .profileuserList.isNotEmpty
                                                ? profileUserProvider
                                                        .profileuserList[0]
                                                        .fullName
                                                        .toString() ??
                                                    ''
                                                : '',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          profileUserProvider
                                                  .profileuserList.isNotEmpty
                                              ? profileUserProvider
                                                      .profileuserList[0]
                                                      .mail ??
                                                  ''
                                              : '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              child: Text(
                                "Sorry don't have date please update profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );

                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(top: 8.h),
                  //     child: Container(
                  //       width: double.infinity,
                  //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //       decoration: BoxDecoration(
                  //         color: Theme.of(context).cardTheme.color,
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(30),
                  //           topRight: Radius.circular(30),
                  //         ),
                  //       ),
                  //       child: Padding(
                  //         padding: EdgeInsets.only(top: 1.h),
                  //         child: Column(
                  //           children: [
                  //             profileUserProvider.profileuserList.isNotEmpty
                  //                 ? Row(
                  //                     children: [
                  //                       CircleAvatar(
                  //                         radius: 6.5.h,
                  //                         backgroundColor: Colors.white,
                  //                         child: CircleAvatar(
                  //                           radius: 6.h,
                  //                           backgroundColor:
                  //                               Colors.grey.withOpacity(0.3),
                  //                           child: GestureDetector(
                  //                             onTap: () {},
                  //                             child: CircleAvatar(
                  //                               backgroundColor: Colors.grey,
                  //                               radius: 5.5.h,
                  //                               backgroundImage:
                  // profileUserProvider
                  //                                           .profileuserList[0]
                  //                                           .avatar !=
                  //                                       null
                  //                                   ? NetworkImage(profileUserProvider
                  //                                       .profileuserList[0].avatar!)
                  //                                   : AssetImage(
                  //                                       'assets/images/dummy_avatar.png',
                  //                                     ) as ImageProvider,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   )
                  //                 : Container(),
                  //             Padding(
                  //                 padding: EdgeInsets.only(bottom: 1.h),
                  //                 child: profileUserProvider
                  //                         .profileuserList.isNotEmpty
                  //                     ? Row(
                  //                         mainAxisAlignment: MainAxisAlignment.start,
                  //                         children: [
                  //                           Container(
                  //                             //  width: 250,
                  //                             //height: .h,
                  //                             padding: EdgeInsets.only(left: 35.w),
                  //                             child: Row(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.spaceAround,
                  //                               children: [
                  //                                 Column(
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment.center,
                  //                                   crossAxisAlignment:
                  //                                       CrossAxisAlignment.start,
                  //                                   children: [
                  //                                     Row(
                  //                                       children: [
                  //                                         Container(
                  //                                           width: 55.w,
                  //                                           child: Text(
                  //                                             profileUserProvider
                  //                                                     .profileuserList
                  //                                                     .isNotEmpty
                  //                                                 ? profileUserProvider
                  //                                                         .profileuserList[
                  //                                                             0]
                  //                                                         .fullName
                  //                                                         .toString() ??
                  //                                                     ''
                  //                                                 : '',
                  //                                             overflow: TextOverflow
                  //                                                 .ellipsis,
                  //                                             maxLines: 2,
                  //                                           ),
                  //                                         ),
                  //                                       ],
                  //                                     ),
                  //                                     Text(
                  //                                       profileUserProvider
                  //                                               .profileuserList
                  //                                               .isNotEmpty
                  //                                           ? profileUserProvider
                  //                                                   .profileuserList[
                  //                                                       0]
                  //                                                   .mail ??
                  //                                               ''
                  //                                           : '',
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       )
                  //                     : Container()),
                  //             SizedBox(
                  //               height: 1.h,
                  //             ),
                  //             const Divider(
                  //               color: Colors.black12,
                  //               thickness: 1,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                }))),
    );
  }
}
