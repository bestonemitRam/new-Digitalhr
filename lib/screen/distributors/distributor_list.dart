import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/provider/shopprovider.dart';
import 'package:bmiterp/screen/distributors/distributorList_screen.dart';
import 'package:bmiterp/screen/distributors/distributor_screen.dart';
import 'package:bmiterp/screen/shop_module/list_ui.dart';
import 'package:bmiterp/widget/leave_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DistributorList extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<ShopProvider>(context, listen: true);
    final distributor = leaveData.distributor;
   
    if (distributor.isNotEmpty) 
    {
      return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: distributor.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DistributorScreenListData(
                  id: distributor[i].id!,
                  distributorAvatar: distributor[i].distributorAvatar!,
                  distributorOrgName: distributor[i].distributorOrgName!,
                  fullName: distributor[i].fullName!,
                  address: distributor[i].address!,
                  mail: distributor[i].mail!,
                  contact: distributor[i].contact!,
                  isActive: distributor[i].isActive!,
                  createdAt: distributor[i].createdAt!,
                  updatedAt: distributor[i].updatedAt!,
                  stateName: distributor[i].stateName!,
                  districtName: distributor[i].districtName!,
                  is_varified: distributor[i].is_varified!),
            );
          });
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Center(
          child: Text(
            "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
