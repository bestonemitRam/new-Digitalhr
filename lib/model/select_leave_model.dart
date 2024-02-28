// class SelectLeaveTypeModel {
//   String? message;
//   bool? status;
//   int? statusCode;
//   Datas? data;

//   SelectLeaveTypeModel({this.message, this.status, this.statusCode, this.data});

//   SelectLeaveTypeModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new Datas.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Datas {
//   List<LeaveTypeList>? leaveTypeList;

//   Datas({this.leaveTypeList});

//   Datas.fromJson(Map<String, dynamic> json) {
//     if (json['leaveTypeList'] != null) {
//       leaveTypeList = <LeaveTypeList>[];
//       json['leaveTypeList'].forEach((v) {
//         leaveTypeList!.add(new LeaveTypeList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.leaveTypeList != null) {
//       data['leaveTypeList'] =
//           this.leaveTypeList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class LeaveTypeList {
//   int? leaveTypeId;
//   String? available;
//   String? leaveTypeName;

//   LeaveTypeList({this.leaveTypeId, this.available, this.leaveTypeName});

//   LeaveTypeList.fromJson(Map<String, dynamic> json) {
//     leaveTypeId = json['leave_type_id'];
//     available = json['available'];
//     leaveTypeName = json['leave_type_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['leave_type_id'] = this.leaveTypeId;
//     data['available'] = this.available;
//     data['leave_type_name'] = this.leaveTypeName;
//     return data;
//   }
// }

class SelectLeaveTypeModel 
{
  bool? status;
  String? message;
  Result? result;

  SelectLeaveTypeModel({this.status, this.message, this.result});

  SelectLeaveTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  List<LeaveTypes>? leaveTypes;

  Result({this.leaveTypes});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['leave_types'] != null) {
      leaveTypes = <LeaveTypes>[];
      json['leave_types'].forEach((v) {
        leaveTypes!.add(new LeaveTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveTypes != null) {
      data['leave_types'] = this.leaveTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTypes {
  int? id;
  String? leaveTypeName;

  LeaveTypes({this.id, this.leaveTypeName});

  LeaveTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}

