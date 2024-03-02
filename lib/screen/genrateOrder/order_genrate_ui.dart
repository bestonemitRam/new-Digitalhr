import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/provider/shopprovider.dart';
import 'package:bmiterp/screen/shop_module/create_shop_screen.dart';
import 'package:bmiterp/screen/shop_module/selcet_shop.dart';
import 'package:bmiterp/screen/shop_module/shop_list.dart';
import 'package:bmiterp/utils/constant.dart';
import 'package:bmiterp/widget/buttonborder.dart';
import 'package:bmiterp/widget/leavescreen/issueleavesheet.dart';
import 'package:bmiterp/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:bmiterp/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderGenerate extends StatefulWidget {
  const OrderGenerate({super.key});

  @override
  State<OrderGenerate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OrderGenerate> {
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
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final leaveData = await leaveProvider.getShopList();
    EasyLoading.dismiss(animation: true);

    if (!mounted) {
      return "Loaded";
    }

    // if (leaveData.statusCode != 200) {
    //   showToast(leaveData!.message!);
    // }

    return "Loaded";
  }

  List<String> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add('Item ${items.length + 1}');
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
                  "Create Order",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 3.w),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        items.add('Item ${items.length + 1}');
                      });
                    },
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: HexColor("#036eb7"),
                    shape: ButtonBorder(),
                    fixedSize: Size(double.maxFinite, 55)),
                onPressed: () {
                  //validateValue();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(width: 90.w, child: SelectShop());
            },
          )),
    );
  }
}
