
// class HomeScreenModel {
//   dynamic? message;
//   bool? status;
//   dynamic? statusCode;
//   HomeData? data;

//   HomeScreenModel({this.message, this.status, this.statusCode, this.data});

//   HomeScreenModel.fromJson(Map<dynamic, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     statusCode = json['statusCode'];
//     data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     data['statusCode'] = this.statusCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class HomeData {
//   Counts? counts;
//   OfficeData? officeData;
//   EmployeeAttendanceData? employeeAttendanceData;

//   HomeData({this.counts, this.officeData, this.employeeAttendanceData});

//   HomeData.fromJson(Map<dynamic, dynamic> json) {
//     counts =
//         json['Counts'] != null ? new Counts.fromJson(json['Counts']) : null;
//     officeData = json['OfficeData'] != null
//         ? new OfficeData.fromJson(json['OfficeData'])
//         : null;
//     employeeAttendanceData = json['EmployeeAttendanceData'] != null
//         ? new EmployeeAttendanceData.fromJson(json['EmployeeAttendanceData'])
//         : null;
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     if (this.counts != null) {
//       data['Counts'] = this.counts!.toJson();
//     }
//     if (this.officeData != null) {
//       data['OfficeData'] = this.officeData!.toJson();
//     }
//     if (this.employeeAttendanceData != null) {
//       data['EmployeeAttendanceData'] = this.employeeAttendanceData!.toJson();
//     }
//     return data;
//   }
// }

// class Counts {
//   dynamic? presentCount;
//   dynamic? holidayCount;
//   dynamic? leaveCount;
//   dynamic? taskCount;

//   Counts(
//       {this.presentCount, this.holidayCount, this.leaveCount, this.taskCount});

//   Counts.fromJson(Map<dynamic, dynamic> json) {
//     presentCount = json['presentCount'];
//     holidayCount = json['holidayCount'];
//     leaveCount = json['leaveCount'];
//     taskCount = json['taskCount'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['presentCount'] = this.presentCount;
//     data['holidayCount'] = this.holidayCount;
//     data['leaveCount'] = this.leaveCount;
//     data['taskCount'] = this.taskCount;
//     return data;
//   }
// }

// class OfficeData {
//   dynamic? openingTime;
//   dynamic? closingTime;

//   OfficeData({this.openingTime, this.closingTime});

//   OfficeData.fromJson(Map<dynamic, dynamic> json) {
//     openingTime = json['opening_time'];
//     closingTime = json['closing_time'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['opening_time'] = this.openingTime;
//     data['closing_time'] = this.closingTime;
//     return data;
//   }
// }

// class EmployeeAttendanceData {
//   dynamic checkIn;
//   dynamic checkOut;
//   dynamic? productionTime;
//   dynamic? production_hour;

//   EmployeeAttendanceData(
//       {this.checkIn, this.checkOut, this.productionTime, this.production_hour});

//   EmployeeAttendanceData.fromJson(Map<dynamic, dynamic> json) {
//     checkIn = json['check-in'];
//     checkOut = json['check-out'];

//     productionTime = json['production-time'];
//     production_hour = json['production_hour'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
//     data['check-in'] = this.checkIn;
//     data['check-out'] = this.checkOut;

//     data['production-time'] = this.productionTime;
//     data['production_hour'] = this.production_hour;

//     return data;
//   }
// }


class HomeScreenModel 
{
  bool? status;
  String? message;
 HomeData? data;

  HomeScreenModel({this.status, this.message, this.data});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['result'] != null ? new HomeData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['result'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeData
 {
  int? presentCount;
  int? holidayCount;
  OfficeTime? officeTime;
  EmployeeAttendanceData? punchData;
  int? taskCount;
  int? leaveCount;

  HomeData(
      {this.presentCount,
      this.holidayCount,
      this.officeTime,
      this.punchData,
      this.taskCount,
      this.leaveCount});

  HomeData.fromJson(Map<String, dynamic> json) {
    presentCount = json['presentCount'];
    holidayCount = json['holidayCount'];
    officeTime = json['officeTime'] != null
        ? new OfficeTime.fromJson(json['officeTime'])
        : null;
    punchData = json['punch_data'] != null
        ? new EmployeeAttendanceData.fromJson(json['punch_data'])
        : null;
    taskCount = json['taskCount'];
    leaveCount = json['leaveCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presentCount'] = this.presentCount;
    data['holidayCount'] = this.holidayCount;
    if (this.officeTime != null) {
      data['officeTime'] = this.officeTime!.toJson();
    }
    if (this.punchData != null) {
      data['punch_data'] = this.punchData!.toJson();
    }
    data['taskCount'] = this.taskCount;
    data['leaveCount'] = this.leaveCount;
    return data;
  }
}

class OfficeTime {
  String? startTime;
  String? endTime;

  OfficeTime({this.startTime, this.endTime});

  OfficeTime.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

class EmployeeAttendanceData {
  String? punchInTime;
  String? punchOutTime;
  String? totalWorkingHours;

  EmployeeAttendanceData({this.punchInTime, this.punchOutTime, this.totalWorkingHours});

  EmployeeAttendanceData.fromJson(Map<String, dynamic> json) {
    punchInTime = json['punch_in_time'];
    punchOutTime = json['punch_out_time'];
    totalWorkingHours = json['total_working_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['punch_in_time'] = this.punchInTime;
    data['punch_out_time'] = this.punchOutTime;
    data['total_working_hours'] = this.totalWorkingHours;
    return data;
  }
}

