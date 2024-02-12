import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/provider/shopprovider.dart';
import 'package:cnattendance/screen/distributors/distributorList_screen.dart';
import 'package:cnattendance/screen/distributors/distributor_screen.dart';
import 'package:cnattendance/screen/shop_module/list_ui.dart';
import 'package:cnattendance/widget/leave_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistributorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<ShopProvider>(context, listen: true);
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
              child: DistributorScreenListData(
                id: shops[i].id,
                shopName: shops[i].shopName,
                ownerName: shops[i].ownerName,
                shopAddress: shops[i].shopAddress,
              ),
            );
          });
    } else {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Currently don't have shop ",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
