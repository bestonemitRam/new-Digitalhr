class DistributorModel {
  bool? status;
  String? message;
  DistributorData? result;

  DistributorModel({this.status, this.message, this.result});

  DistributorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['result'] != null
        ? new DistributorData.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class DistributorData {
  List<DistributorList>? distributorList;
  String? baseImageUrl;

  DistributorData({this.distributorList, this.baseImageUrl});

  DistributorData.fromJson(Map<String, dynamic> json) {
    if (json['distributor_list'] != null) {
      distributorList = <DistributorList>[];
      json['distributor_list'].forEach((v) {
        distributorList!.add(new DistributorList.fromJson(v));
      });
    }
    baseImageUrl = json['base_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distributorList != null) {
      data['distributor_list'] =
          this.distributorList!.map((v) => v.toJson()).toList();
    }
    data['base_image_url'] = this.baseImageUrl;
    return data;
  }
}

class DistributorList {
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

  DistributorList(
      {this.id,
      this.distributorAvatar,
      this.distributorOrgName,
      this.fullName,
      this.address,
      this.mail,
      this.contact,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.stateName,
      this.districtName,
      this.is_varified});

  DistributorList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distributorAvatar = json['distributor_avatar'];
    distributorOrgName = json['distributor_org_name'];
    fullName = json['full_name'];
    address = json['address'];
    mail = json['mail'];
    contact = json['contact'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    is_varified = json['is_varified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['distributor_avatar'] = this.distributorAvatar;
    data['distributor_org_name'] = this.distributorOrgName;
    data['full_name'] = this.fullName;
    data['address'] = this.address;
    data['mail'] = this.mail;
    data['contact'] = this.contact;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['is_varified'] = this.is_varified;
    return data;
  }
}
