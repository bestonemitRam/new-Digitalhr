import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/provider/shopprovider.dart';
import 'package:bmiterp/screen/shop_module/list_ui.dart';
import 'package:bmiterp/widget/leave_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context, listen: true);
    final shops = leaveData.shoplist;
    if (shops.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: shops.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListUi(
                id: shops[i].id,
                retailerName: shops[i].retailerName,
                retailerShopName: shops[i].retailerShopName,
                retailerAddress: shops[i].retailerAddress,
                retailerLatitude: shops[i].retailerLatitude,
                retailerLongitude: shops[i].retailerLongitude,
                retailerShopImage: shops[i].retailerShopImage,
                isVarified: shops[i].isVarified,
              ),
            );
          });
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 300),
        child: Center(
          child: Container(
            height: 50.h,
            child: Text(
              "",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
