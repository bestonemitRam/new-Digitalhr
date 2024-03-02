import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/widget/cancel_leave_bottom_sheet.dart';
import 'package:bmiterp/widget/log_out_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ListUi extends StatelessWidget {
  int? id;
  dynamic retailerName;
  dynamic retailerShopName;
  dynamic retailerAddress;
  dynamic retailerLatitude;
  dynamic retailerLongitude;
  dynamic retailerShopImage;
  int? isVarified;
  ListUi({
    required this.id,
    required this.retailerName,
    required this.retailerShopName,
    required this.retailerAddress,
    required this.retailerLatitude,
    required this.retailerLongitude,
    required this.retailerShopImage,
    required this.isVarified,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Row(
                    children: [
                      Text(
                        "Shop Name : ",
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "$retailerName",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: TextStyle(
                              color: HexColor("#036eb7"), fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Owner Name : ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "$retailerName",
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Shop Address : ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "$retailerName",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          style: TextStyle(
                              color: HexColor("#036eb7"), fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  //Text(
                  //   status,
                  //   style: TextStyle(color: HexColor("#036eb7"), fontSize: 12),
                  // ),
                  // Text(
                  //   authorization == '' ? "N/A" : "By: $authorization",
                  //   style: TextStyle(color: HexColor("#036eb7"), fontSize: 12),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
