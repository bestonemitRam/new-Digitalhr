import 'dart:ffi';

import 'package:cnattendance/api/app_strings.dart';
import 'package:cnattendance/data/source/network/model/login/User.dart';
import 'package:cnattendance/data/source/network/model/login/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  // Save  SAVE_USER_LOGIN_DATA
  Future<bool> saveUser(Login data) async {
    // Obtain shared preferences.
    User user = data.user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Apphelper.USER_TOKEN, data.tokens);
    await prefs.setInt(Apphelper.USER_ID, user.id);
    await prefs.setString(Apphelper.USER_AVATAR, user.avatar);
    await prefs.setString(Apphelper.USER_EMAIL, user.email);
    await prefs.setString(Apphelper.USER_NAME, user.username);
    await prefs.setString(Apphelper.USER_FULLNAME, user.name);
    notifyListeners();
    return true;
  }

  // Future<bool> saveUser(String tokens, int userId, String userAvatar,
  //     String userEmail, String userName, String name) async
  //      {
  //   // Obtain shared preferences.

  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(Apphelper.USER_TOKEN, tokens);
  //   await prefs.setInt(Apphelper.USER_ID, userId);
  //   await prefs.setString(Apphelper.USER_AVATAR, userAvatar);
  //   await prefs.setString(Apphelper.USER_EMAIL, userEmail);
  //   await prefs.setString(Apphelper.USER_NAME, userName);
  //   await prefs.setString(Apphelper.USER_FULLNAME, name);
  //   notifyListeners();
  //   return true;
  // }

  /// Save_BASIC_USER_DATA
  void saveBasicUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Apphelper.USER_ID, user.id);
    await prefs.setString(Apphelper.USER_AVATAR, user.avatar);
    await prefs.setString(Apphelper.USER_EMAIL, user.email);
    await prefs.setString(Apphelper.USER_NAME, user.username);
    await prefs.setString(Apphelper.USER_FULLNAME, user.name);
    notifyListeners();
  }

  /// CLEAR_PREFERENCE_DATA
  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Apphelper.USER_ID, 0);
    await prefs.setString(Apphelper.USER_TOKEN, '');
    await prefs.setString(Apphelper.USER_AVATAR, '');
    await prefs.setString(Apphelper.USER_EMAIL, '');
    await prefs.setString(Apphelper.USER_NAME, '');
    await prefs.setString(Apphelper.USER_FULLNAME, '');
    await prefs.setBool(Apphelper.USER_AUTH, false);
    await prefs.setBool(Apphelper.APP_IN_ENGLISH, true);
    notifyListeners();
  }

  /// SAVE_USER_AUTHENTICATION
  void saveUserAuth(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Apphelper.USER_AUTH, value);
  }

  /// SAVE_APP_IN_ENGLISH
  void saveAppEng(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Apphelper.APP_IN_ENGLISH, value);
  }

  /// SAVE_APP_IN_ENGLISH
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return User(
        id: prefs.getInt(Apphelper.USER_ID) ?? 0,
        name: prefs.getString(Apphelper.USER_FULLNAME) ?? "",
        email: prefs.getString(Apphelper.USER_EMAIL) ?? "",
        username: prefs.getString(Apphelper.USER_NAME) ?? "",
        avatar: prefs.getString(Apphelper.USER_AVATAR) ?? "");
  }

  /// GET_TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.token = prefs.getString(Apphelper.USER_TOKEN) ?? '';
    Apphelper.dob = prefs.getString(Apphelper.dob) ?? '';
    Apphelper.contact = prefs.getString(Apphelper.contact) ?? '';
    Apphelper.contact = prefs.getString(Apphelper.contact) ?? '';
    Apphelper.gendar = prefs.getString(Apphelper.gendar) ?? '';

    return prefs.getString(Apphelper.USER_TOKEN) ?? '';
  }

  ///USER_ID
  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Apphelper.USER_ID) ?? 0;
  }

  /// GET_USER_AUTH
  Future<bool> getUserAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Apphelper.USER_AUTH) ?? false;
  }

  /// GET_USER_NAME
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.userName = prefs.getString(Apphelper.USER_NAME) ?? "";
    return prefs.getString(Apphelper.USER_NAME) ?? "";
  }

  /// GET_EMAIL
  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.email = prefs.getString(Apphelper.USER_EMAIL) ?? "";
    return prefs.getString(Apphelper.USER_EMAIL) ?? "";
  }

  /// GET_AVATAR
  Future<String> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.USER_AVATAR = prefs.getString(Apphelper.USER_AVATAR) ?? "";
    return prefs.getString(Apphelper.USER_AVATAR) ?? "";
  }

  /// GET_FULL_NAME
  Future<String> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    Apphelper.name = prefs.getString(Apphelper.USER_FULLNAME) ?? "";
    return prefs.getString(Apphelper.USER_FULLNAME) ?? "";
  }

  Future<bool> getEnglishDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Apphelper.APP_IN_ENGLISH) ?? true;
  }
}
