class ShopDataResponse {
  bool? status;
  int? statusCode;
  String? message;
  Datass? data;

  ShopDataResponse({this.status, this.statusCode, this.message, this.data});

  ShopDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Datass.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Datass {
  List<ShopList>? shopList;

  Datass({this.shopList});

  Datass.fromJson(Map<String, dynamic> json) {
    if (json['shopList'] != null) {
      shopList = <ShopList>[];
      json['shopList'].forEach((v) {
        shopList!.add(new ShopList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shopList != null) {
      data['shopList'] = this.shopList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopList {
  int? id;
  String? shopName;
  String? ownerName;
  String? shopAddress;

  ShopList({this.id, this.shopName, this.ownerName, this.shopAddress});

  ShopList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    ownerName = json['owner_name'];
    shopAddress = json['shop_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_name'] = this.shopName;
    data['owner_name'] = this.ownerName;
    data['shop_address'] = this.shopAddress;
    return data;
  }
}
