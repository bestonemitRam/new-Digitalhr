// import 'LeaveTypeDetail.dart';

// class Leavetypedetailreponse {
//   Leavetypedetailreponse({
//     required this.status,
//     required this.message,
//     required this.statusCode,
//     required this.data,});

//   factory Leavetypedetailreponse.fromJson(dynamic json) {
//     return Leavetypedetailreponse(
//         status: json['status'],
//         message: json['message'],
//         statusCode: json['status_code'],
//         data: List<LeaveTypeDetail>.from(
//             json['data'].map((x) => LeaveTypeDetail.fromJson(x))));

//   }

//   bool status;
//   String message;
//   int statusCode;
//   List<LeaveTypeDetail> data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['status_code'] = statusCode;
//     map['data'] = data.map((v) => v.toJson()).toList();
//     return map;
//   }

// }




class Leavetypedetailreponse {
  bool? status;
  int? statusCode;
  String? message;
  LeaveData? data;

  Leavetypedetailreponse(
      {this.status, this.statusCode, this.message, this.data});

  Leavetypedetailreponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new LeaveData.fromJson(json['data']) : null;
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

class LeaveData {
  List<LeaveList>? leaveList;

  LeaveData({this.leaveList});

  LeaveData.fromJson(Map<String, dynamic> json) {
    if (json['leave_list'] != null) {
      leaveList = <LeaveList>[];
      json['leave_list'].forEach((v) {
        leaveList!.add(new LeaveList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveList != null) {
      data['leave_list'] = this.leaveList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveList {
  int? id;
  String? leaveFrom;
  String? leaveTo;
  String? leaveReason;
  String? status;
  String? leaveTypeName;

  LeaveList(
      {this.id,
      this.leaveFrom,
      this.leaveTo,
      this.leaveReason,
      this.status,
      this.leaveTypeName});

  LeaveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveFrom = json['leave_from'];
    leaveTo = json['leave_to'];
    leaveReason = json['leave_reason'];
    status = json['status'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_from'] = this.leaveFrom;
    data['leave_to'] = this.leaveTo;
    data['leave_reason'] = this.leaveReason;
    data['status'] = this.status;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}
