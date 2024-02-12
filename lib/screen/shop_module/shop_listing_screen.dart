import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/provider/shopprovider.dart';
import 'package:cnattendance/screen/shop_module/create_shop_screen.dart';
import 'package:cnattendance/screen/shop_module/shop_list.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:cnattendance/widget/leavescreen/issueleavesheet.dart';
import 'package:cnattendance/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShopListingScreen extends StatefulWidget {
  const ShopListingScreen({super.key});

  @override
  State<ShopListingScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ShopListingScreen> {
  var init = true;
  var isVisible = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final leaveProvider = Provider.of<ShopProvider>(context, listen: false);
    final leaveData = await leaveProvider.getShopList();
    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    if (leaveData.statusCode != 200) {
      showToast(leaveData!.message!);
    }

    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                "My Shop",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 0,
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: CreateShopScreen(),
                          );
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.white24,
                      child: Text(
                        "Add Shop",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ShopList(),
                ],
              ),
            ),
          )),
    );
  }
}
