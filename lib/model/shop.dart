import 'package:flutter/material.dart';
class Shop with ChangeNotifier
 {
  int id;
  String shopName;
    String ownerName;
      String shopAddress;
  

  Shop(
      {required this.id,
      required this.shopName,
      required this.ownerName,
      required this.shopAddress,
     });
}
