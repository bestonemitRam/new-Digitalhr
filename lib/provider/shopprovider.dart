import 'dart:convert';

import 'package:bmiterp/api/apiConstant.dart';
import 'package:bmiterp/data/source/datastore/preferences.dart';
import 'package:bmiterp/model/distributor_data_list.dart';
import 'package:bmiterp/model/distributor_model.dart';
import 'package:bmiterp/model/distributor_state_model.dart';
import 'package:bmiterp/model/shop.dart';
import 'package:bmiterp/model/shopresponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShopProvider with ChangeNotifier {
  final List<Shop> _shoplist = [];
  final List<Distributor> _distributor = [];
  final List<StateDataList> _stateDataList = [];

  List<StateDataList> get statelist {
    return [..._stateDataList];
  }

  List<Shop> get shoplist {
    return [..._shoplist];
  }

  List<Distributor> get distributor {
    return [..._distributor];
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

  void makeDistributorList(DistributorData data) {
    _distributor.clear();

    for (var distributor in data.distributorList!) {
      _distributor.add(Distributor(
          id: distributor.id,
          distributorAvatar: distributor.distributorAvatar,
          distributorOrgName: distributor.distributorOrgName,
          fullName: distributor.fullName,
          address: distributor.address,
          mail: distributor.mail,
          contact: distributor.contact,
          isActive: distributor.isActive,
          createdAt: distributor.createdAt,
          updatedAt: distributor.updatedAt,
          stateName: distributor.stateName,
          districtName: distributor.districtName,
          is_varified: distributor.is_varified));
    }

    notifyListeners();
  }

  void stateList(DisStateModel data) 
  {
    _stateDataList.clear();
    String? stateName;
    String? stateCode;

    for (var result in data.result!) {
      _stateDataList.add(StateDataList(
        id: result.id,
        stateName: result.stateName,
        stateCode: result.stateCode,
      ));
    }

    notifyListeners();
  }

  Future<DistributorModel> getDistributorList() async {
    print("check get all shop list data ");
    var uri = Uri.parse(APIURL.DISTRIBUTOR_LIST);

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
      final responseJson = DistributorModel.fromJson(responseData);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        makeDistributorList(responseJson.result!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<DisStateModel> getStateList() async {
    print("check get all state list data ");
    var uri = Uri.parse(APIURL.DISTRIBUTOR_STATE_LIST);

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

      print("Checkdfdg leave data ${responseData}");
      final responseJson = DisStateModel.fromJson(responseData);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        stateList(responseJson!);

        return responseJson;
      } else {
        var errorMessage = responseData['message'];
        return responseJson;
      }
    } catch (error) {
      throw error;
    }
  }


}
