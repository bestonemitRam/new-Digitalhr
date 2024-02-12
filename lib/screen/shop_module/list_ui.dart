import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/widget/cancel_leave_bottom_sheet.dart';
import 'package:cnattendance/widget/log_out_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ListUi extends StatelessWidget {
  final int id;
  final String shopName;
  final String ownerName;
  final String shopAddress;

  ListUi({
    required this.id,
    required this.shopName,
    required this.ownerName,
    required this.shopAddress,
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
                          "$shopName",
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
                        "$ownerName",
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
                          "$shopAddress",
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
