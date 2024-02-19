// import 'LeaveType.dart';

// class Leavetyperesponse {
//   Leavetyperesponse({
//     required this.status,
//     required this.message,
//     required this.statusCode,
//     required this.data,
//   });

//   factory Leavetyperesponse.fromJson(dynamic json) {
//     return Leavetyperesponse(
//         status: json['status'],
//         message: json['message'],
//         statusCode: json['status_code'],
//         data: List<LeaveType>.from(
//             json['data'].map((x) => LeaveType.fromJson(x))));
//   }

//   bool status;
//   String message;
//   int statusCode;
import 'package:cnattendance/data/source/network/model/leavetype/LeaveType.dart';

//List<LeaveType> data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['status_code'] = statusCode;
//     map['data'] = data.map((v) => v.toJson()).toList();
//     return map;
//   }
// }

class Leavetyperesponse {
  String? message;
  bool? status;
  int? statusCode;
  Data? data;

  Leavetyperesponse({this.message, this.status, this.statusCode, this.data});

  Leavetyperesponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<LeaveType>? leaveTypeData;

  Data({this.leaveTypeData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leaveTypeData'] != null) {
      leaveTypeData = <LeaveType>[];
      json['leaveTypeData'].forEach((v) {
        leaveTypeData!.add(new LeaveType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveTypeData != null) {
      data['leaveTypeData'] =
          this.leaveTypeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveType {
  int? id;
  String? alloted;
  String? taken;
  String? available;
  String? leaveTypeName;

  LeaveType(
      {this.id, this.alloted, this.taken, this.available, this.leaveTypeName});

  LeaveType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alloted = json['alloted'];
    taken = json['taken'];
    available = json['available'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alloted'] = this.alloted;
    data['taken'] = this.taken;
    data['available'] = this.available;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}
