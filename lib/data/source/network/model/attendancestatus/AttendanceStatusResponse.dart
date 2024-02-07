import 'AttendanceStatus.dart';

class AttendanceStatusResponse {
  AttendanceStatusResponse({
    required this.message,
    required this.status,
    required this.statusCode,
    required this.data,
  });

  factory AttendanceStatusResponse.fromJson(dynamic json) {
    AttendanceStatus? data = AttendanceStatus(checkInAt:"", checkOutAt: "", productiveTimeInMin: 0);
    if (json['data'] != null){
      data = AttendanceStatus.fromJson(json['data']);
    }
    return AttendanceStatusResponse(
      message: json['message'],
      status: json['status'],
      statusCode: json['statusCode'],
      data: data,
    );
  }

  bool status;
  String message;
  int statusCode;
  AttendanceStatus data;
  Map<String, dynamic>? toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    map['statusCode'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
