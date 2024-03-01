import 'package:flutter/material.dart';

class Distributor with ChangeNotifier {
  int? id;
  String? distributorAvatar;
  String? distributorOrgName;
  String? fullName;
  String? address;
  String? mail;
  String? contact;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? stateName;
  String? districtName;
  int? is_varified;

  Distributor(
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
      required this.is_varified
      });
}
