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
//   dynamic? presentCount;
//   dynamic? holidayCount;
//   dynamic? leaveCount;
//   dynamic? taskCount;

//   HomeData(
//       {this.presentCount, this.holidayCount, this.leaveCount, this.taskCount});

//   HomeData.fromJson(Map<dynamic, dynamic> json) {
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

class HomeScreenModel {
  dynamic? message;
  bool? status;
  dynamic? statusCode;
  HomeData? data;

  HomeScreenModel({this.message, this.status, this.statusCode, this.data});

  HomeScreenModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    status = json['status'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeData {
  Counts? counts;
  OfficeData? officeData;
  EmployeeAttendanceData? employeeAttendanceData;

  HomeData({this.counts, this.officeData, this.employeeAttendanceData});

  HomeData.fromJson(Map<dynamic, dynamic> json) {
    counts =
        json['Counts'] != null ? new Counts.fromJson(json['Counts']) : null;
    officeData = json['OfficeData'] != null
        ? new OfficeData.fromJson(json['OfficeData'])
        : null;
    employeeAttendanceData = json['EmployeeAttendanceData'] != null
        ? new EmployeeAttendanceData.fromJson(json['EmployeeAttendanceData'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.counts != null) {
      data['Counts'] = this.counts!.toJson();
    }
    if (this.officeData != null) {
      data['OfficeData'] = this.officeData!.toJson();
    }
    if (this.employeeAttendanceData != null) {
      data['EmployeeAttendanceData'] = this.employeeAttendanceData!.toJson();
    }
    return data;
  }
}

class Counts {
  dynamic? presentCount;
  dynamic? holidayCount;
  dynamic? leaveCount;
  dynamic? taskCount;

  Counts(
      {this.presentCount, this.holidayCount, this.leaveCount, this.taskCount});

  Counts.fromJson(Map<dynamic, dynamic> json) {
    presentCount = json['presentCount'];
    holidayCount = json['holidayCount'];
    leaveCount = json['leaveCount'];
    taskCount = json['taskCount'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['presentCount'] = this.presentCount;
    data['holidayCount'] = this.holidayCount;
    data['leaveCount'] = this.leaveCount;
    data['taskCount'] = this.taskCount;
    return data;
  }
}

class OfficeData {
  dynamic? openingTime;
  dynamic? closingTime;

  OfficeData({this.openingTime, this.closingTime});

  OfficeData.fromJson(Map<dynamic, dynamic> json) {
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    return data;
  }
}

class EmployeeAttendanceData {
  dynamic? checkIn;
  dynamic? checkOut;
  dynamic? productionHour;
  dynamic? productionTime;

  EmployeeAttendanceData(
      {this.checkIn, this.checkOut, this.productionHour, this.productionTime});

  EmployeeAttendanceData.fromJson(Map<dynamic, dynamic> json) {
    checkIn = json['check-in'];
    checkOut = json['check-out'];
    productionHour = json['production_hour'];
    productionTime = json['production-time'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['check-in'] = this.checkIn;
    data['check-out'] = this.checkOut;
    data['production_hour'] = this.productionHour;
    data['production-time'] = this.productionTime;
    return data;
  }
}
