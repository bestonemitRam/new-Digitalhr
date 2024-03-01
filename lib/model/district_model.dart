class DistrictModel 
{
  bool? status;
  String? message;
  List<DistrictData>? resultData;

  DistrictModel({this.status, this.message, this.resultData});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      resultData = <DistrictData>[];
      json['result'].forEach((v) {
        resultData!.add(new DistrictData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.resultData != null) {
      data['result'] = this.resultData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictData {
  int? id;
  String? districtName;

  DistrictData({this.id, this.districtName});

  DistrictData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtName = json['district_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_name'] = this.districtName;
    return data;
  }
}
