import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/screen/profile/editprofilescreen.dart';
import 'package:cnattendance/widget/profile/basicdetail.dart';
import 'package:cnattendance/widget/profile/bankdetail.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cnattendance/widget/profile/heading.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  var initalState = true;

  @override
  void didChangeDependencies() {
    if (initalState) {
      getProfileDetail();
      initalState = false;
    }
    super.didChangeDependencies();
  }

  var isLoading = true;

  Future<String> getProfileDetail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<ProfileProvider>(context, listen: false).getProfile();
    } catch (e) {
      return "loaded";
    }

    setState(() {
      isLoading = false;
    });
    return "loaded";
  }

  @override
  Widget build(BuildContext context) {
    final userProfile =
        Provider.of<ProfileProvider>(context, listen: false).profile;
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
        body: RefreshIndicator(
          onRefresh: () {
            return getProfileDetail();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Heading(),
                userProfile.post != ''
                    ? Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 10),
                        width: double.infinity,
                        child: const Text(
                          'Other Details',
                          style: TextStyle(color: Colors.white38, fontSize: 15),
                        ),
                      )
                    : SizedBox(),
                userProfile.post != '' ? BasicDetail() : SizedBox(),
                userProfile.bankName != ''
                    ? Container(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 10),
                        width: double.infinity,
                        child: const Text(
                          'Bank Details',
                          style: TextStyle(color: Colors.white38, fontSize: 15),
                        ),
                      )
                    : SizedBox(),
                userProfile.bankName != '' ? BankDetail() : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
