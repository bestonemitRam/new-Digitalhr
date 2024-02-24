import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/widget/cancel_leave_bottom_sheet.dart';
import 'package:bmiterp/widget/log_out_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class DistributorScreenListData extends StatelessWidget {
  final int id;
  final String shopName;
  final String ownerName;
  final String shopAddress;

  DistributorScreenListData({
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
                        "Full Name : ",
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
                        "Email : ",
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
                        "Mobile No. : ",
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
                  Row(
                    children: [
                      Text(
                        "Address : ",
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
                  Row(
                    children: [
                      Text(
                        "Fund Amount : ",
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
