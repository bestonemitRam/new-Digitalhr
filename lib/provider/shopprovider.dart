import 'dart:convert';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/model/shop.dart';
import 'package:bmiterp/model/shopresponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopProvider with ChangeNotifier {
  final List<Shop> _shoplist = [];

  List<Shop> get shoplist {
    return [..._shoplist];
  }

  Future<ShopDataResponse> getShopList() async {
    print("check get all shop list data ");
    var uri = Uri.parse(APIURL.SHOP_LIST);

    Preferences preferences = Preferences();
    String token = await preferences.getToken();
    int getUserID = await preferences.getUserId();
    print('response >> ');
    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'user_token': '$token',
      'user_id': '$getUserID',
    };
    try {
      final response = await http.get(uri, headers: headers);
      final responseData = json.decode(response.body);

      print("Check leave data ${responseData}");
      final responseJson = ShopDataResponse.fromJson(responseData);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        makeShopList(responseJson.data!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }

  void makeShopList(Data data) {
    _shoplist.clear();

    for (var shop in data.shopList!) {
      _shoplist.add(Shop(
          id: int.parse(shop.id.toString() ?? '0'),
          shopName: shop.shopName!,
          ownerName: shop.ownerName!,
          shopAddress: shop.shopAddress!));
    }

    notifyListeners();
  }
}
