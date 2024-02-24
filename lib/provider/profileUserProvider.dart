import 'dart:convert';
import 'dart:io';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/api/app_strings.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/data/source/network/model/dashboard/User.dart';
import 'package:bmiterp/data/source/network/model/login/Login.dart';
import 'package:bmiterp/data/source/network/model/profile/Profileresponse.dart';
import 'package:bmiterp/model/ProfileUserModel.dart';
import 'package:bmiterp/provider/prefprovider.dart';
import 'package:bmiterp/utils/constant.dart';
import 'package:bmiterp/utils/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bmiterp/model/profile.dart' as up;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUserProvider with ChangeNotifier {
  ProfileUserModel profileuserModel = ProfileUserModel();

  List<ProfileDatas> _profileuserlist = [];
  List<ProfileDatas> get profileuserList => _profileuserlist;

  bool datanotfound = false;

  Future profileuserlist() async {
    datanotfound = false;

    var url = APIURL.PROFILE_URL;

    ServiceWithHeader service = ServiceWithHeader(url);
    final response = await service.data();

    _profileuserlist = [];
    profileuserModel = ProfileUserModel.fromJson(response);

    if (profileuserModel.data != null) {
      if (profileuserModel.data!.profileData != null) {
        print("dkfhgjfjhgjhg sdds ${profileuserModel.data}");
        var profileuser = profileuserModel.data!.profileData;
        _profileuserlist.add(profileuser!);
        parseUser(profileuserModel.data!.profileData!);
        Apphelper.dob = profileuserModel.data!.profileData!.dob!;
        Apphelper.gendar = profileuserModel.data!.profileData!.gender!;
        Apphelper.contact = profileuserModel.data!.profileData!.contact!;
        Apphelper.USER_AVATAR = profileuserModel.data!.profileData!.avatar!;
        Apphelper.name = profileuserModel.data!.profileData!.fullName!;
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
            Apphelper.USER_AVATAR, profileuserModel.data!.profileData!.avatar!);
        await prefs.setString(
            Apphelper.USER_EMAIL, profileuserModel.data!.profileData!.mail!);
        await prefs.setString(Apphelper.USER_FULLNAME,
            profileuserModel.data!.profileData!.fullName!);
        await prefs.setString(
            Apphelper.gendar, profileuserModel.data!.profileData!.gender!);
        await prefs.setString(
            Apphelper.contact, profileuserModel.data!.profileData!.contact!);
        await prefs.setString(
            Apphelper.dob, profileuserModel.data!.profileData!.dob!);
        Apphelper.dob = profileuserModel.data!.profileData!.dob!;
        Apphelper.gendar = profileuserModel.data!.profileData!.gender!;
        Apphelper.contact = profileuserModel.data!.profileData!.contact!;
        Apphelper.USER_AVATAR = profileuserModel.data!.profileData!.avatar!;
        Apphelper.name = profileuserModel.data!.profileData!.fullName!;
      }
    }
    datanotfound = true;
    notifyListeners();
  }

  final up.Profile _profile = up.Profile(
      id: 0,
      avatar: '',
      name: '',
      username: '',
      email: '',
      post: '',
      phone: '',
      dob: '',
      gender: '',
      address: '',
      bankName: '',
      bankNumber: '',
      joinedDate: '');

  up.Profile get profile {
    return _profile;
  }

  void parseUser(ProfileDatas profile) {
    _profile.id = profile.userId!;
    _profile.avatar = profile.avatar!;
    _profile.name = profile.fullName!;
    _profile.username = profile.fullName!;
    _profile.email = profile.mail!;
    _profile.post = '';
    _profile.phone = profile.contact!;
    _profile.dob = profile.dob!;
    _profile.gender = profile.gender!;
    _profile.address = "";
    _profile.bankName = "";
    _profile.bankNumber = "";
    _profile.joinedDate = "";

    notifyListeners();
  }
}
