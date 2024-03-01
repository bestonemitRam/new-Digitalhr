import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/provider/leaveprovider.dart';
import 'package:bmiterp/widget/cancel_leave_bottom_sheet.dart';
import 'package:bmiterp/widget/log_out_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DistributorScreenListData extends StatelessWidget {
  final int id;
  final String distributorAvatar;
  final String distributorOrgName;
  final String fullName;
  final String address;
  final String mail;
  final String contact;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  final String stateName;
  final String districtName;
  final int is_varified;

  DistributorScreenListData(
      {required this.id,
      required this.distributorAvatar,
      required this.distributorOrgName,
      required this.fullName,
      required this.address,
      required this.mail,
      required this.contact,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt,
      required this.stateName,
      required this.districtName,
      required this.is_varified});

  @override
  Widget build(BuildContext context) {
    print("kfjghghgh   ${APIURL.production + "storage/" + distributorAvatar}");
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Container(
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                //   backgroundColor: Colors.white,
                radius: 4.h,
                backgroundImage: distributorAvatar.isNotEmpty
                    ? NetworkImage(
                        APIURL.production + "storage/" + distributorAvatar)
                    : AssetImage(
                        'assets/images/dummy_avatar.png',
                      ) as ImageProvider,
              ),
            ),

            Column(
              // textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Status : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "${is_varified == 0 ? "Not Verify" : "Verify"} ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style: TextStyle(
                            color: is_varified == 0 ? Colors.red : Colors.green,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Org. Name : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$distributorOrgName",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Name : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$fullName",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Phone No. : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$contact",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Email : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$mail",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "State : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$stateName",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "District : ",
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        "$districtName",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
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
                        "$address",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        style:
                            TextStyle(color: HexColor("#036eb7"), fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10),
            //     child: Container(
            //       color: Colors.green,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           'pending',
            //           style: TextStyle(color: Colors.white, fontSize: 12),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // Color getStatus() {
  //   switch (status) {
  //     case "Approved":
  //       return Colors.green;
  //     case "Rejected":
  //       return Colors.redAccent;
  //     case "Pending":
  //       return Colors.orange;
  //     case "Cancelled":
  //       return Colors.red;
  //     default:
  //       return Colors.orange;
  //   }
  // }
}
