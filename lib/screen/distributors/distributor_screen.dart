import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/provider/shopprovider.dart';
import 'package:bmiterp/screen/distributors/create_distributor_screen.dart';
import 'package:bmiterp/screen/distributors/distributor_list.dart';
import 'package:bmiterp/screen/shop_module/create_shop_screen.dart';
import 'package:bmiterp/screen/shop_module/shop_list.dart';
import 'package:bmiterp/utils/constant.dart';
import 'package:bmiterp/widget/leavescreen/issueleavesheet.dart';
import 'package:bmiterp/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DistributorScreen extends StatefulWidget {
  const DistributorScreen({super.key});

  @override
  State<DistributorScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DistributorScreen> {
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

  Future<String> initialState() async 
  {
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);
    final leaveProvider = Provider.of<ShopProvider>(context, listen: false);
    final leaveData = await leaveProvider.getDistributorList();
    final stateList = await leaveProvider.getStateList();
    
    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    if (leaveData == 200)
     {
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
                "Distributor List",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () 
                  {
                    showModalBottomSheet(
                        elevation: 0,
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        builder: (context) 
                        {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: CreateDistributorScreen(),
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
                        "Add New Distributor",
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
                  DistributorList(),
                ],
              ),
            ),
          )),
    );
  }
}
